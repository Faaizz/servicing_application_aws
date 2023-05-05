# IAM
resource "aws_iam_role" "this" {
  name_prefix = join("", ["ExecRole", var.function_name])
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "this" {
  for_each = { for pp in var.policy_permissions : pp.name => pp.content }
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = each.key
        Action   = each.value.actions
        Effect   = "Allow"
        Resource = each.value.resources
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "queue_sqs_full" {
  for_each   = aws_iam_policy.this
  role       = resource.aws_iam_role.this.name
  policy_arn = each.value.arn
}

# API GATEWAY
resource "aws_api_gateway_resource" "this" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_resource_id
  path_part   = var.api_path
}

resource "aws_api_gateway_method" "this" {
  rest_api_id      = var.rest_api_id
  resource_id      = aws_api_gateway_resource.this.id
  http_method      = var.http_method
  authorization    = var.http_auth
  api_key_required = var.api_key_required
}

resource "aws_api_gateway_method_response" "this" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = var.status_code
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.this.id
  http_method             = aws_api_gateway_method.this.http_method
  integration_http_method = var.http_method
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}

resource "aws_api_gateway_integration_response" "this" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = aws_api_gateway_method_response.this.status_code

  depends_on = [
    aws_api_gateway_integration.this,
  ]
}

data "archive_file" "extractor" {
  type             = "zip"
  source_file      = var.source_file_path
  output_file_mode = "0666"
  output_path      = local.source_zip_path
}

# LAMBDA
resource "aws_lambda_function" "this" {
  filename      = data.archive_file.extractor.output_path
  function_name = var.function_name
  role          = aws_iam_role.this.arn
  handler       = var.function_handler
  runtime       = "python3.9"
  layers        = var.layer_arns

  environment {
    variables = { for ev in var.env_variables : ev.name => ev.value }
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowcoreAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${var.api_execution_arn}/*/*/*"
}
