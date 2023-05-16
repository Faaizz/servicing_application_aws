# CW Logs Loge Group for API Logs
# API Gateway Service automatically routes logs to this log grouop based on the specified naming convention
resource "aws_cloudwatch_log_group" "core_dev" {
  name              = "API-Gateway-Execution-Logs_${var.api_id}/${var.stage_name}"
  retention_in_days = 3
}


resource "aws_api_gateway_deployment" "core_dev" {
  rest_api_id = var.api_id
}

resource "aws_api_gateway_stage" "core_dev" {
  deployment_id = aws_api_gateway_deployment.core_dev.id
  rest_api_id   = var.api_id
  stage_name    = var.stage_name

  depends_on = [
    aws_cloudwatch_log_group.core_dev,
  ]
}

resource "aws_api_gateway_method_settings" "core_dev" {
  rest_api_id = var.api_id
  stage_name  = aws_api_gateway_stage.core_dev.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = var.api_log_level
  }
}

# Usage Plans
resource "aws_api_gateway_usage_plan" "core_unlimited" {
  name        = "unlimited"
  description = "Unlimited usage plan"

  api_stages {
    api_id = var.api_id
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
