variable "github_access_token" {
  description = "GitHub access token for repository access"
  type        = string
  sensitive   = true
}

variable "github_repo_url" {
  description = "Github repository url"
  type        = string
}

variable "github_repo_branch" {
  description = "Github repository branch name"
  type        = string
}

variable "backend_tf_backend" {
  description = "Backend terraform backend configuration"
  type        = map(string)
}
