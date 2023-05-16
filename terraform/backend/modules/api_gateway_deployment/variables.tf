variable "api_id" {
  description = "The ID of the API to deploy"
  type        = string
}
variable "stage_name" {
  description = "The name of the stage to deploy"
  type        = string
}
variable "api_log_level" {
  description = "The log level for the API Gateway"
  type        = string
}
