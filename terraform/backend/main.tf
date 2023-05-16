module "source_repository" {
  source = "./modules/source_repository"

  github_repo_url    = var.github_repo_url
  source_code_suffix = var.source_code_suffix
  base_directory     = local.base_directory
}

module "storage" {
  source = "./modules/storage"

  results_bucket_name = "core-order-results"

  codes_table_name = "Codes"
  nodes_table_name = "NodeStatus"

  codes_queue_name = "Codes"
}

# Lambda Layer
module "lambda_layer" {
  source = "./modules/lambda_layer"

  name            = "${var.core_backend_service}_services"
  source_zip_path = local.source_zip_path

  depends_on = [
    data.archive_file.lambda_layer,
  ]
}

# API GATEWAY
module "api_gateway" {
  source = "./modules/api_gateway"
}

module "verification" {
  source = "./modules/verification"

  verification_admin_email = var.verification_admin_email
  rest_api_id              = module.api_gateway.id
  parent_id                = module.api_gateway.root_resource_id
  api_execution_arn        = module.api_gateway.execution_arn

  dynamodb_table     = module.storage.codes_dynamodb_table_id
  dynamodb_table_arn = module.storage.codes_dynamodb_table_arn

  source_code_path_prefix = local.source_code_path

  lambda_layer_arn = module.lambda_layer.arn

  core_backend_service = var.core_backend_service

  depends_on = [
    module.source_repository,
  ]
}

module "order_extraction" {
  source = "./modules/order_extraction"

  rest_api_id       = module.api_gateway.id
  parent_id         = module.api_gateway.root_resource_id
  api_execution_arn = module.api_gateway.execution_arn

  dynamodb_table     = module.storage.codes_dynamodb_table_id
  dynamodb_table_arn = module.storage.codes_dynamodb_table_arn
  sqs_queue_arn      = module.storage.codes_queue_arn
  sqs_queue_url      = module.storage.codes_queue_url
  result_bucket_id   = module.storage.results_bucket_id
  result_bucket_arn  = module.storage.results_bucket_arn

  source_code_path_prefix = local.source_code_path

  lambda_layer_arn = module.lambda_layer.arn

  depends_on = [
    module.source_repository,
  ]
}

module "code_checker" {
  source = "./modules/code_checker"

  rest_api_id       = module.api_gateway.id
  parent_id         = module.api_gateway.root_resource_id
  api_execution_arn = module.api_gateway.execution_arn

  dynamodb_table     = module.storage.codes_dynamodb_table_id
  dynamodb_table_arn = module.storage.codes_dynamodb_table_arn
  sqs_queue_arn      = module.storage.codes_queue_arn
  sqs_queue_url      = module.storage.codes_queue_url

  source_code_path_prefix = local.source_code_path

  lambda_layer_arn = module.lambda_layer.arn

  depends_on = [
    module.source_repository,
  ]
}

module "node_status" {
  source = "./modules/node_status"

  rest_api_id       = module.api_gateway.id
  parent_id         = module.api_gateway.root_resource_id
  api_execution_arn = module.api_gateway.execution_arn

  dynamodb_table     = module.storage.nodes_dynamodb_table_id
  dynamodb_table_arn = module.storage.nodes_dynamodb_table_arn

  source_code_path_prefix = local.source_code_path

  lambda_layer_arn = module.lambda_layer.arn

  depends_on = [
    module.source_repository,
  ]
}

module "api_gateway_deployment" {
  source = "./modules/api_gateway_deployment"

  api_id        = module.api_gateway.id
  api_log_level = var.api_log_level
  stage_name    = var.stage_name

  depends_on = [
    module.code_checker,
    module.order_extraction,
    module.verification,
    module.node_status,
  ]
}
