# microsoft_services

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.63.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_code_checker"></a> [code\_checker](#module\_code\_checker) | ./modules/code_checker | n/a |
| <a name="module_dynamodb_codes"></a> [dynamodb\_codes](#module\_dynamodb\_codes) | terraform-aws-modules/dynamodb-table/aws | 3.2.0 |
| <a name="module_dynamodb_node_status"></a> [dynamodb\_node\_status](#module\_dynamodb\_node\_status) | terraform-aws-modules/dynamodb-table/aws | 3.2.0 |
| <a name="module_node_status"></a> [node\_status](#module\_node\_status) | ./modules/node_status | n/a |
| <a name="module_order_extraction"></a> [order\_extraction](#module\_order\_extraction) | ./modules/order_extraction | n/a |
| <a name="module_verification"></a> [verification](#module\_verification) | ./modules/verification | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_account.current](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_account) | resource |
| [aws_api_gateway_api_key.core_trial](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_api_key) | resource |
| [aws_api_gateway_api_key.core_unlimited](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_api_key) | resource |
| [aws_api_gateway_deployment.core_dev](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_method_settings.core_dev](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_method_settings) | resource |
| [aws_api_gateway_rest_api.core](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_stage.core_dev](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_stage) | resource |
| [aws_api_gateway_usage_plan.core_trial](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_usage_plan) | resource |
| [aws_api_gateway_usage_plan.core_unlimited](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_usage_plan) | resource |
| [aws_api_gateway_usage_plan_key.core_trial](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_usage_plan_key) | resource |
| [aws_api_gateway_usage_plan_key.core_unlimited](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_usage_plan_key) | resource |
| [aws_cloudwatch_log_group.core_dev](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_access_key.worker_node_asus_1](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_access_key) | resource |
| [aws_iam_group.worker_nodes](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_group) | resource |
| [aws_iam_group_policy.worker_nodes](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_group_policy) | resource |
| [aws_iam_policy.api_gw_to_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.api_gw_to_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.api_gw_to_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.worker_node_asus_1](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.worker_node_asus_1](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_user_group_membership) | resource |
| [aws_s3_bucket.results](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.extracted_order](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_sqs_queue.codes](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/sqs_queue) | resource |
| [null_resource.get_source_code](https://registry.terraform.io/providers/hashicorp/null/3.2.1/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_log_level"></a> [api\_log\_level](#input\_api\_log\_level) | API log level | `string` | `"INFO"` | no |
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
| <a name="output_trial_api_key"></a> [trial\_api\_key](#output\_trial\_api\_key) | Trial API key |
| <a name="output_unlimited_api_key"></a> [unlimited\_api\_key](#output\_unlimited\_api\_key) | Unlimited API key |
| <a name="output_verification_topic_arn"></a> [verification\_topic\_arn](#output\_verification\_topic\_arn) | ARN of email verification SNS Topic |
| <a name="output_worker_node_asus_1_access_key"></a> [worker\_node\_asus\_1\_access\_key](#output\_worker\_node\_asus\_1\_access\_key) | Access key for worker node asus\_1 |
| <a name="output_worker_node_asus_1_secret_key"></a> [worker\_node\_asus\_1\_secret\_key](#output\_worker\_node\_asus\_1\_secret\_key) | Secret key for worker node asus\_1 |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
