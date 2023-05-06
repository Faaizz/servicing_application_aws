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

variable "result_bucket_id" {
  type        = string
  description = "S3 bucket ID for storing order extraction results"
}

variable "result_bucket_arn" {
  type        = string
  description = "S3 bucket ARN for storing order extraction results"
}

variable "source_code_path_prefix" {
  type        = string
  description = "Source code path prefix"
}

variable "lambda_layer_arn" {
  type        = string
  description = "Lambda layer ARN"
}
