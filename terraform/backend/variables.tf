variable "stage_name" {
  type        = string
  description = "API stage name"
  default     = "dev"
}

variable "api_log_level" {
  type        = string
  description = "API log level"
  default     = "INFO"
}

variable "verification_admin_email" {
  type        = string
  description = "Email to which all verification notices are sent by default."
  validation {
    condition = length(
      regexall("\\w+@\\w+\\.\\w+", var.verification_admin_email)
    ) > 0
    error_message = "Invalid email supplied."
  }
  default = "core1@outlook.com"
}

variable "github_repo_url" {
  description = "Github repository url"
  type        = string
}

variable "source_code_suffix" {
  description = "Source code path in Github repository"
  type        = string
  default     = "code"
}
