output "gh_actions_role_arn" {
  value       = module.iam_github_oidc_role.arn
  description = "GitHub actions role ARN"
}
