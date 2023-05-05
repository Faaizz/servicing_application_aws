variable "functions" {
  description = "Lambda functions to create"
  type = list(object({
    api_execution_arn  = string
    rest_api_id        = string
    parent_resource_id = string
    api_path           = string
    api_key_required   = bool

    function_name    = string
    source_file_path = string
    function_handler = string
    env_variables    = list(map(string))

    policy_permissions = list(object({
      name = string
      content = object({
        actions   = list(string)
        resources = list(string)
      })
    }))
  }))
}

variable "source_code_path" {
  type        = string
  description = "Source code path"
}
