# Terraform State
resource "aws_s3_bucket" "this" {
  bucket        = var.s3_bucket_name
  force_destroy = true
}

module "iam_github_oidc_role" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version     = "5.10"
  name_prefix = "GitHubOIDCRole-"

  subjects = ["${var.github_user}/${var.github_repo}:*"]

  policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
}

module "iam_github_oidc_provider" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
  version = "5.10"

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]
}
