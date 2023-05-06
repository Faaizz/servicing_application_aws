resource "aws_api_gateway_resource" "order_extraction" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "orderextraction"
}

resource "aws_api_gateway_resource" "result" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.order_extraction.id
  path_part   = "result"
}

resource "aws_api_gateway_resource" "result_upload" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.result.id
  path_part   = "{key}"
}
resource "aws_api_gateway_method" "result_upload" {
  rest_api_id      = var.rest_api_id
  resource_id      = aws_api_gateway_resource.result_upload.id
  http_method      = "PUT"
  authorization    = "NONE"
  api_key_required = true

  request_parameters = {
    "method.request.path.key" = true
  }
}
resource "aws_api_gateway_integration" "result_upload" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.result_upload.id
  http_method             = aws_api_gateway_method.result_upload.http_method
  integration_http_method = "PUT"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:s3:path/${var.result_bucket_id}/extracted_order/{key}"

  credentials = aws_iam_role.api_gw_to_s3.arn

  request_parameters = {
    "integration.request.path.key" = "method.request.path.key"
  }
}
resource "aws_api_gateway_method_response" "result_upload" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.result_upload.id
  http_method = aws_api_gateway_method.result_upload.http_method
  status_code = 200
}
resource "aws_api_gateway_integration_response" "result_upload" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.result_upload.id
  http_method = aws_api_gateway_method.result_upload.http_method
  status_code = aws_api_gateway_method_response.result_upload.status_code

  depends_on = [
    aws_api_gateway_integration.result_upload,
  ]
}

resource "aws_api_gateway_method" "result_download" {
  rest_api_id      = var.rest_api_id
  resource_id      = aws_api_gateway_resource.result_upload.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true

  request_parameters = {
    "method.request.path.key" = true
  }
}
resource "aws_api_gateway_integration" "result_download" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.result_upload.id
  http_method             = aws_api_gateway_method.result_download.http_method
  integration_http_method = "GET"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:s3:path/${var.result_bucket_id}/extracted_order/{key}"

  credentials = aws_iam_role.api_gw_to_s3.arn

  request_parameters = {
    "integration.request.path.key" = "method.request.path.key"
  }
}
resource "aws_api_gateway_method_response" "result_download" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.result_upload.id
  http_method = aws_api_gateway_method.result_download.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.content-type" = true
  }
}
resource "aws_api_gateway_integration_response" "result_download" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.result_upload.id
  http_method = aws_api_gateway_method.result_download.http_method
  status_code = aws_api_gateway_method_response.result_download.status_code

  response_parameters = {
    "method.response.header.content-type" = "integration.response.header.content-type"
  }

  depends_on = [
    aws_api_gateway_integration.result_download,
  ]
}


module "lambdas_orderextraction" {
  source = "../lambdas"

  lambda_layer_arn = var.lambda_layer_arn

  functions = [
    {
      api_execution_arn  = var.api_execution_arn
      rest_api_id        = var.rest_api_id
      parent_resource_id = aws_api_gateway_resource.order_extraction.id
      api_path           = "queue"
      api_key_required   = true

      function_name    = "queueorderextraction"
      source_file_path = "${var.source_code_path_prefix}/queue_orderextraction_f.py"
      function_handler = "queue_orderextraction_f.lambda_handler"
      env_variables = [
        {
          name  = "TABLE_NAME"
          value = var.dynamodb_table
        },
        {
          name  = "QUEUE_URL"
          value = var.sqs_queue_url
        }
      ]

      policy_permissions = [
        {
          name = "CloudWatchLogsWrite"
          content = {
            actions = [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ]
            resources = ["*"]
          }
        },
        {
          name = "DynamoDBWrite"
          content = {
            actions = [
              "dynamodb:PutItem"
            ]
            resources = [var.dynamodb_table_arn]
          }
        },
        {
          name = "SQSFullAccess"
          content = {
            actions = [
              "sqs:*"
            ]
            resources = [var.sqs_queue_arn]
          }
        }
      ]
    },
    {
      api_execution_arn  = var.api_execution_arn
      rest_api_id        = var.rest_api_id
      parent_resource_id = aws_api_gateway_resource.order_extraction.id
      api_path           = "poll"
      api_key_required   = false

      function_name    = "pollorderextraction"
      source_file_path = "${var.source_code_path_prefix}/poll_orderextraction_f.py"
      function_handler = "poll_orderextraction_f.lambda_handler"
      env_variables = [
        {
          name  = "TABLE_NAME"
          value = var.dynamodb_table
        }
      ]

      policy_permissions = [
        {
          name = "CloudWatchLogsWrite"
          content = {
            actions = [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ]
            resources = ["*"]
          }
        },
        {
          name = "DynamoDBRead"
          content = {
            actions = [
              "dynamodb:GetItem"
            ]
            resources = [var.dynamodb_table_arn]
          }
        }
      ]
    }
  ]
}
