resource "aws_api_gateway_resource" "node_status" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "status"
}

module "lambdas_node_status" {
  source = "../lambdas"

  source_code_path = var.source_code_path_prefix

  functions = [
    {
      api_execution_arn  = var.api_execution_arn
      rest_api_id        = var.rest_api_id
      parent_resource_id = aws_api_gateway_resource.node_status.id
      api_path           = "node"
      api_key_required   = true

      function_name    = "nodestatus"
      source_file_path = "${var.source_code_path_prefix}/nodes_f.py"
      function_handler = "nodes_f.lambda_handler"
      env_variables = [
        {
          name  = "NODE_STATUS_TABLE_NAME"
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
          name = "DynamoDBRead"
          content = {
            actions = [
              "dynamodb:GetItem",
              "dynamodb:Scan",
            ]
            resources = [var.dynamodb_table_arn]
          }
        },
      ]
    },
  ]
}
