module "lambda_integration" {
  source = "../lambda_integration"

  for_each = { for function in var.functions : function.function_name => function }

  layer_arns = [var.lambda_layer_arn]

  api_execution_arn  = each.value.api_execution_arn
  rest_api_id        = each.value.rest_api_id
  parent_resource_id = each.value.parent_resource_id
  api_path           = each.value.api_path
  api_key_required   = each.value.api_key_required

  function_name    = each.value.function_name
  source_file_path = each.value.source_file_path
  function_handler = each.value.function_handler
  env_variables    = each.value.env_variables

  policy_permissions = each.value.policy_permissions
}
