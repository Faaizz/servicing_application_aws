# order_extraction

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambdas_orderextraction"></a> [lambdas\_orderextraction](#module\_lambdas\_orderextraction) | ../lambdas | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_integration.result_download](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration.result_upload](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration_response.result_download](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_integration_response) | resource |
| [aws_api_gateway_integration_response.result_upload](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_integration_response) | resource |
| [aws_api_gateway_method.result_download](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method.result_upload](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method_response.result_download](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_method_response) | resource |
| [aws_api_gateway_method_response.result_upload](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_method_response) | resource |
| [aws_api_gateway_resource.order_extraction](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_resource) | resource |
| [aws_api_gateway_resource.result](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_resource) | resource |
| [aws_api_gateway_resource.result_upload](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_resource) | resource |
| [aws_iam_policy.api_gw_to_s3](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.api_gw_to_s3](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.api_gw_to_s3](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_execution_arn"></a> [api\_execution\_arn](#input\_api\_execution\_arn) | API Gateway execution ARN | `string` | n/a | yes |
| <a name="input_dynamodb_table"></a> [dynamodb\_table](#input\_dynamodb\_table) | DynamoDB table name | `string` | n/a | yes |
| <a name="input_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#input\_dynamodb\_table\_arn) | DynamoDB table ARN | `string` | n/a | yes |
| <a name="input_lambda_layer_arn"></a> [lambda\_layer\_arn](#input\_lambda\_layer\_arn) | Lambda layer ARN | `string` | n/a | yes |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | API Gateway parent resource ID | `string` | n/a | yes |
| <a name="input_rest_api_id"></a> [rest\_api\_id](#input\_rest\_api\_id) | API Gateway REST API ID | `string` | n/a | yes |
| <a name="input_result_bucket_arn"></a> [result\_bucket\_arn](#input\_result\_bucket\_arn) | S3 bucket ARN for storing order extraction results | `string` | n/a | yes |
| <a name="input_result_bucket_id"></a> [result\_bucket\_id](#input\_result\_bucket\_id) | S3 bucket ID for storing order extraction results | `string` | n/a | yes |
| <a name="input_source_code_path_prefix"></a> [source\_code\_path\_prefix](#input\_source\_code\_path\_prefix) | Source code path prefix | `string` | n/a | yes |
| <a name="input_sqs_queue_arn"></a> [sqs\_queue\_arn](#input\_sqs\_queue\_arn) | SQS queue ARN | `string` | n/a | yes |
| <a name="input_sqs_queue_url"></a> [sqs\_queue\_url](#input\_sqs\_queue\_url) | SQS queue URL | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
