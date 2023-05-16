# api_gateway_deployment

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.63.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_api_key.core_unlimited](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_api_key) | resource |
| [aws_api_gateway_deployment.core_dev](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_method_settings.core_dev](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_method_settings) | resource |
| [aws_api_gateway_stage.core_dev](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_stage) | resource |
| [aws_api_gateway_usage_plan.core_unlimited](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_usage_plan) | resource |
| [aws_api_gateway_usage_plan_key.core_unlimited](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_usage_plan_key) | resource |
| [aws_cloudwatch_log_group.core_dev](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/cloudwatch_log_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_id"></a> [api\_id](#input\_api\_id) | The ID of the API to deploy | `string` | n/a | yes |
| <a name="input_api_log_level"></a> [api\_log\_level](#input\_api\_log\_level) | The log level for the API Gateway | `string` | n/a | yes |
| <a name="input_stage_name"></a> [stage\_name](#input\_stage\_name) | The name of the stage to deploy | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_invoke_url"></a> [invoke\_url](#output\_invoke\_url) | invoke URL for API |
| <a name="output_unlimited_api_key"></a> [unlimited\_api\_key](#output\_unlimited\_api\_key) | Unlimited API key |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
