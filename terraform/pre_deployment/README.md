## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.61.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_github_oidc_provider"></a> [iam\_github\_oidc\_provider](#module\_iam\_github\_oidc\_provider) | terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider | 5.10 |
| <a name="module_iam_github_oidc_role"></a> [iam\_github\_oidc\_role](#module\_iam\_github\_oidc\_role) | terraform-aws-modules/iam/aws//modules/iam-github-oidc-role | 5.10 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | Github repository name | `string` | n/a | yes |
| <a name="input_github_user"></a> [github\_user](#input\_github\_user) | Github username | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | S3 bucket name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gh_actions_role_arn"></a> [gh\_actions\_role\_arn](#output\_gh\_actions\_role\_arn) | GitHub actions role ARN |
