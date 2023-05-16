variable "github_repo_url" {
  type        = string
  description = "URL of the GitHub repository"
}
variable "source_code_suffix" {
  type        = string
  description = "Suffix of the source code directory within the GitHub repository"
}
variable "base_directory" {
  type        = string
  description = "Local directory where the source code will be cloned"
}
