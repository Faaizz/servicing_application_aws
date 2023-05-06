resource "aws_api_gateway_resource" "codechecker" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "codechecker"
}

module "lambdas_codechecker" {
  source = "../lambdas"

  lambda_layer_arn = var.lambda_layer_arn

  functions = [
    {
      api_execution_arn  = var.api_execution_arn
      rest_api_id        = var.rest_api_id
      parent_resource_id = aws_api_gateway_resource.codechecker.id
      api_path           = "queue"
      api_key_required   = true

      function_name    = "queuecodechecker"
      source_file_path = "${var.source_code_path_prefix}/queue_codechecker_f.py"
      function_handler = "queue_codechecker_f.lambda_handler"
      env_variables = [
        {
          name  = "TABLE_NAME"
          value = var.dynamodb_table
        },
        {
          name  = "QUEUE_URL"
          value = var.sqs_queue_url
        },
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
          name = "DynamoDBReadWrite"
          content = {
            actions = [
              "dynamodb:GetItem",
              "dynamodb:PutItem",
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
      parent_resource_id = aws_api_gateway_resource.codechecker.id
      api_path           = "poll"
      api_key_required   = true

      function_name    = "pollcodechecker"
      source_file_path = "${var.source_code_path_prefix}/poll_codechecker_f.py"
      function_handler = "poll_codechecker_f.lambda_handler"
      env_variables = [
        {
          name  = "TABLE_NAME"
          value = var.dynamodb_table
        },
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
          name = "DynamoDBReadWrite"
          content = {
            actions = [
              "dynamodb:GetItem",
              "dynamodb:PutItem",
            ]
            resources = [var.dynamodb_table_arn]
          }
        },
      ]
    },
  ]
}
