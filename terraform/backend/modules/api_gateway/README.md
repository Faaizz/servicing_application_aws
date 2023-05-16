# api_gateway

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
| [aws_api_gateway_account.current](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_account) | resource |
| [aws_api_gateway_rest_api.core](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_rest_api) | resource |
| [aws_iam_policy.api_gw_to_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.api_gw_to_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.api_gw_to_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_execution_arn"></a> [execution\_arn](#output\_execution\_arn) | ARN of the API Gateway execution |
| <a name="output_id"></a> [id](#output\_id) | ID of the API Gateway |
| <a name="output_root_resource_id"></a> [root\_resource\_id](#output\_root\_resource\_id) | ID of the root resource |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
