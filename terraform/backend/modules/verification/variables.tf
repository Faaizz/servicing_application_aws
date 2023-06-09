variable "verification_admin_email" {
  type        = string
  description = "Email to which all verification notices are sent by default."
}

variable "rest_api_id" {
  type        = string
  description = "API Gateway REST API ID"
}

variable "parent_id" {
  type        = string
  description = "API Gateway parent resource ID"
}

variable "api_execution_arn" {
  type        = string
  description = "API Gateway execution ARN"
}

variable "dynamodb_table" {
  type        = string
  description = "DynamoDB table name"
}

variable "dynamodb_table_arn" {
  type        = string
  description = "DynamoDB table ARN"
}

variable "source_code_path_prefix" {
  type        = string
  description = "Source code path prefix"
}

variable "lambda_layer_arn" {
  type        = string
  description = "Lambda layer ARN"
}

variable "core_backend_service" {
  description = "Core backend service name"
  type        = string
}
