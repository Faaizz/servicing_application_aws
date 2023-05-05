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

variable "sqs_queue_arn" {
  type        = string
  description = "SQS queue ARN"
}

variable "sqs_queue_url" {
  type        = string
  description = "SQS queue URL"
}

variable "source_code_path_prefix" {
  type        = string
  description = "Source code path prefix"
}
