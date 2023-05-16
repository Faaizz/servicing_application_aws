# microsoft_services

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.63.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | ./modules/api_gateway | n/a |
| <a name="module_api_gateway_deployment"></a> [api\_gateway\_deployment](#module\_api\_gateway\_deployment) | ./modules/api_gateway_deployment | n/a |
| <a name="module_code_checker"></a> [code\_checker](#module\_code\_checker) | ./modules/code_checker | n/a |
| <a name="module_lambda_layer"></a> [lambda\_layer](#module\_lambda\_layer) | ./modules/lambda_layer | n/a |
| <a name="module_node_status"></a> [node\_status](#module\_node\_status) | ./modules/node_status | n/a |
| <a name="module_order_extraction"></a> [order\_extraction](#module\_order\_extraction) | ./modules/order_extraction | n/a |
| <a name="module_source_repository"></a> [source\_repository](#module\_source\_repository) | ./modules/source_repository | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./modules/storage | n/a |
| <a name="module_verification"></a> [verification](#module\_verification) | ./modules/verification | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.worker_node_asus_1](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_access_key) | resource |
| [aws_iam_group.worker_nodes](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_group) | resource |
| [aws_iam_group_policy.worker_nodes](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_group_policy) | resource |
| [aws_iam_user.worker_node_asus_1](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.worker_node_asus_1](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_user_group_membership) | resource |
| [archive_file.lambda_layer](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_log_level"></a> [api\_log\_level](#input\_api\_log\_level) | API log level | `string` | `"INFO"` | no |
| <a name="input_core_backend_service"></a> [core\_backend\_service](#input\_core\_backend\_service) | Core backend service name | `string` | n/a | yes |
| <a name="input_github_repo_url"></a> [github\_repo\_url](#input\_github\_repo\_url) | Github repository url | `string` | n/a | yes |
| <a name="input_source_code_suffix"></a> [source\_code\_suffix](#input\_source\_code\_suffix) | Source code path in Github repository | `string` | `"code"` | no |
| <a name="input_stage_name"></a> [stage\_name](#input\_stage\_name) | API stage name | `string` | `"dev"` | no |
| <a name="input_verification_admin_email"></a> [verification\_admin\_email](#input\_verification\_admin\_email) | Email to which all verification notices are sent by default. | `string` | `"core1@outlook.com"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_url"></a> [api\_url](#output\_api\_url) | invoke URL for API |
| <a name="output_codes_dynamodb_table"></a> [codes\_dynamodb\_table](#output\_codes\_dynamodb\_table) | DynamoDB table for storing codes |
| <a name="output_queue_url"></a> [queue\_url](#output\_queue\_url) | URL of SQS queue for codes |
| <a name="output_unlimited_api_key"></a> [unlimited\_api\_key](#output\_unlimited\_api\_key) | Unlimited API key |
| <a name="output_verification_topic_arn"></a> [verification\_topic\_arn](#output\_verification\_topic\_arn) | ARN of email verification SNS Topic |
| <a name="output_worker_node_asus_1_access_key"></a> [worker\_node\_asus\_1\_access\_key](#output\_worker\_node\_asus\_1\_access\_key) | Access key for worker node asus\_1 |
| <a name="output_worker_node_asus_1_secret_key"></a> [worker\_node\_asus\_1\_secret\_key](#output\_worker\_node\_asus\_1\_secret\_key) | Secret key for worker node asus\_1 |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
