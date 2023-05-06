# Get source code
resource "null_resource" "get_source_code" {
  provisioner "local-exec" {
    working_dir = local.base_directory
    interpreter = ["/bin/bash", "-c"]
    command     = "./scripts/clone_git_repository.sh ${var.github_repo_url} ${var.source_code_suffix}"
  }
}

# S3
resource "aws_s3_bucket" "results" {
  bucket        = "core-order-results"
  force_destroy = true
}

# Delete extracted order files after one day
resource "aws_s3_bucket_lifecycle_configuration" "extracted_order" {
  bucket = aws_s3_bucket.results.id

  rule {
    id = "expire_order_extraction_files"

    filter {
      prefix = "extracted_order/"
    }

    expiration {
      days = 1
    }

    status = "Enabled"
  }
}

# DYNAMODB
module "dynamodb_codes" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.2.0"

  name     = "Codes"
  hash_key = "id"

  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  ttl_enabled        = true
  ttl_attribute_name = "ttl"

  attributes = [
    {
      name = "id"
      type = "S"
    }
  ]
}

module "dynamodb_node_status" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.2.0"

  name     = "NodeStatus"
  hash_key = "id"

  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  ttl_enabled        = true
  ttl_attribute_name = "ttl"

  attributes = [
    {
      name = "id"
      type = "S"
    }
  ]
}

resource "aws_sqs_queue" "codes" {
  name                       = "Codes"
  visibility_timeout_seconds = 600
}


# API GATEWAY
resource "aws_api_gateway_account" "current" {
  cloudwatch_role_arn = aws_iam_role.api_gw_to_cloudwatch.arn
}
resource "aws_api_gateway_rest_api" "core" {
  name = "core-api"
}


# Lambda Layer
resource "aws_lambda_layer_version" "base_layer" {
  filename            = local.source_zip_path
  layer_name          = "microsoft_services"
  compatible_runtimes = ["python3.9"]
  source_code_hash    = can(filesha256(local.source_zip_path)) ? filesha256(local.source_zip_path) : ""

  depends_on = [
    data.archive_file.lambda_layer,
  ]
}

module "verification" {
  source = "./modules/verification"

  verification_admin_email = var.verification_admin_email
  rest_api_id              = aws_api_gateway_rest_api.core.id
  parent_id                = aws_api_gateway_rest_api.core.root_resource_id
  api_execution_arn        = aws_api_gateway_rest_api.core.execution_arn

  dynamodb_table     = module.dynamodb_codes.dynamodb_table_id
  dynamodb_table_arn = module.dynamodb_codes.dynamodb_table_arn

  source_code_path_prefix = local.source_code_path

  lambda_layer_arn = aws_lambda_layer_version.base_layer.arn

  depends_on = [null_resource.get_source_code]
}

module "order_extraction" {
  source = "./modules/order_extraction"

  rest_api_id       = aws_api_gateway_rest_api.core.id
  parent_id         = aws_api_gateway_rest_api.core.root_resource_id
  api_execution_arn = aws_api_gateway_rest_api.core.execution_arn

  dynamodb_table     = module.dynamodb_codes.dynamodb_table_id
  dynamodb_table_arn = module.dynamodb_codes.dynamodb_table_arn
  sqs_queue_arn      = aws_sqs_queue.codes.arn
  sqs_queue_url      = aws_sqs_queue.codes.url
  result_bucket_id   = aws_s3_bucket.results.bucket
  result_bucket_arn  = aws_s3_bucket.results.arn

  source_code_path_prefix = local.source_code_path

  lambda_layer_arn = aws_lambda_layer_version.base_layer.arn

  depends_on = [null_resource.get_source_code]
}

module "code_checker" {
  source = "./modules/code_checker"

  rest_api_id       = aws_api_gateway_rest_api.core.id
  parent_id         = aws_api_gateway_rest_api.core.root_resource_id
  api_execution_arn = aws_api_gateway_rest_api.core.execution_arn

  dynamodb_table     = module.dynamodb_codes.dynamodb_table_id
  dynamodb_table_arn = module.dynamodb_codes.dynamodb_table_arn
  sqs_queue_arn      = aws_sqs_queue.codes.arn
  sqs_queue_url      = aws_sqs_queue.codes.url

  source_code_path_prefix = local.source_code_path

  lambda_layer_arn = aws_lambda_layer_version.base_layer.arn

  depends_on = [null_resource.get_source_code]
}

module "node_status" {
  source = "./modules/node_status"

  rest_api_id       = aws_api_gateway_rest_api.core.id
  parent_id         = aws_api_gateway_rest_api.core.root_resource_id
  api_execution_arn = aws_api_gateway_rest_api.core.execution_arn

  dynamodb_table     = module.dynamodb_node_status.dynamodb_table_id
  dynamodb_table_arn = module.dynamodb_node_status.dynamodb_table_arn

  source_code_path_prefix = local.source_code_path

  lambda_layer_arn = aws_lambda_layer_version.base_layer.arn

  depends_on = [null_resource.get_source_code]
}


# API Deployment
resource "aws_api_gateway_deployment" "core_dev" {
  rest_api_id = aws_api_gateway_rest_api.core.id

  depends_on = [
    module.code_checker,
    module.order_extraction,
    module.verification,
    module.node_status,
  ]
}

resource "aws_api_gateway_stage" "core_dev" {
  deployment_id = aws_api_gateway_deployment.core_dev.id
  rest_api_id   = aws_api_gateway_rest_api.core.id
  stage_name    = var.stage_name

  depends_on = [
    aws_cloudwatch_log_group.core_dev,
  ]
}
resource "aws_api_gateway_method_settings" "core_dev" {
  rest_api_id = aws_api_gateway_rest_api.core.id
  stage_name  = aws_api_gateway_stage.core_dev.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = var.api_log_level
  }
}
# CW Logs Loge Group for API Logs
# API Gateway Service automatically routes logs to this log grouop based on the specified naming convention
resource "aws_cloudwatch_log_group" "core_dev" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.core.id}/${var.stage_name}"
  retention_in_days = 3
}

# Usage Plans
resource "aws_api_gateway_usage_plan" "core_trial" {
  name        = "trial"
  description = "Trial usage plan"

  api_stages {
    api_id = aws_api_gateway_rest_api.core.id
    stage  = aws_api_gateway_stage.core_dev.stage_name
  }

  quota_settings {
    limit  = 10
    period = "DAY"
  }

  throttle_settings {
    burst_limit = 3
    rate_limit  = 5
  }
}
resource "aws_api_gateway_api_key" "core_trial" {
  name = "core_trial"
}
resource "aws_api_gateway_usage_plan_key" "core_trial" {
  key_id        = aws_api_gateway_api_key.core_trial.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.core_trial.id
}

resource "aws_api_gateway_usage_plan" "core_unlimited" {
  name        = "unlimited"
  description = "Unlimited usage plan"

  api_stages {
    api_id = aws_api_gateway_rest_api.core.id
    stage  = aws_api_gateway_stage.core_dev.stage_name
  }

  quota_settings {
    limit  = 10000
    period = "DAY"
  }

  throttle_settings {
    burst_limit = 30
    rate_limit  = 50
  }
}
resource "aws_api_gateway_api_key" "core_unlimited" {
  name = "core_unlimited"
}
resource "aws_api_gateway_usage_plan_key" "core_unlimited" {
  key_id        = aws_api_gateway_api_key.core_unlimited.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.core_unlimited.id
}
