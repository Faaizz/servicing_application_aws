resource "aws_sns_topic" "verification" {
  name              = "microsoft-signin-verification"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "default" {
  topic_arn = aws_sns_topic.verification.arn
  endpoint  = var.verification_admin_email
  protocol  = "email"
}

resource "aws_api_gateway_resource" "verification" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "verification"
}

module "lambdas_verification" {
  source = "../lambdas"

  source_code_path = var.source_code_path_prefix

  functions = [
    {
      api_execution_arn  = var.api_execution_arn
      rest_api_id        = var.rest_api_id
      parent_resource_id = aws_api_gateway_resource.verification.id
      api_path           = "subscription"
      api_key_required   = true

      function_name    = "verificationsubscription"
      source_file_path = "${var.source_code_path_prefix}/verification_subscription_f.py"
      function_handler = "verification_subscription_f.lambda_handler"
      env_variables = [
        {
          name  = "SNS_TOPIC_ARN"
          value = aws_sns_topic.verification.arn
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
          name = "SNSSubscribe"
          content = {
            actions = [
              "sns:Subscribe",
            ]
            resources = [aws_sns_topic.verification.arn]
          }
        },
      ]
    },
    {
      api_execution_arn  = var.api_execution_arn
      rest_api_id        = var.rest_api_id
      parent_resource_id = aws_api_gateway_resource.verification.id
      api_path           = "email"
      api_key_required   = true

      function_name    = "verificationemail"
      source_file_path = "${var.source_code_path_prefix}/verification_email_f.py"
      function_handler = "verification_email_f.lambda_handler"
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
    {
      api_execution_arn  = var.api_execution_arn
      rest_api_id        = var.rest_api_id
      parent_resource_id = aws_api_gateway_resource.verification.id
      api_path           = "code"
      api_key_required   = true

      function_name    = "verificationcode"
      source_file_path = "${var.source_code_path_prefix}/verification_code_f.py"
      function_handler = "verification_code_f.lambda_handler"
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
