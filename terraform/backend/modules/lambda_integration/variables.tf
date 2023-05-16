# IAM
variable "policy_permissions" {
  type = list(object({
    name = string
    content = object({
      actions   = list(string)
      resources = list(string)
    })
  }))
  description = "Policy permissions for lambda execution role."
}

# API GATEWAY
variable "api_execution_arn" {
  type        = string
  description = "Execution ARN for REST API"
}

variable "rest_api_id" {
  type        = string
  description = "ID of REST API"
}

variable "parent_resource_id" {
  type        = string
  description = "ID of parent API resource"
}

variable "api_path" {
  type        = string
  description = "API path to resource"
}

variable "http_method" {
  type        = string
  description = "HTTP Method for API path"
  default     = "POST"
}

variable "http_auth" {
  type        = string
  description = "HTTP Authentication type for API path"
  default     = "NONE"
}

variable "status_code" {
  type        = number
  description = "Return code for API path"
  default     = 200
}

# LAMBDA
variable "function_name" {
  type        = string
  description = "function name"
}

variable "source_file_path" {
  type        = string
  description = "Filesystem path to source ZIP file"
}

variable "function_handler" {
  type        = string
  description = "lambda function handler"
}

variable "env_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Environment variables to pass to function."
  default     = []
}

variable "api_key_required" {
  type        = bool
  description = "API key requirement"
  default     = true
}

variable "layer_arns" {
  type        = list(string)
  description = "Lambda layer ARNs"
}
