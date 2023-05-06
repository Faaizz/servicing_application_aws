# verification

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
| <a name="module_lambdas_verification"></a> [lambdas\_verification](#module\_lambdas\_verification) | ../lambdas | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_resource.verification](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/api_gateway_resource) | resource |
| [aws_sns_topic.verification](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.default](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_execution_arn"></a> [api\_execution\_arn](#input\_api\_execution\_arn) | API Gateway execution ARN | `string` | n/a | yes |
| <a name="input_dynamodb_table"></a> [dynamodb\_table](#input\_dynamodb\_table) | DynamoDB table name | `string` | n/a | yes |
| <a name="input_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#input\_dynamodb\_table\_arn) | DynamoDB table ARN | `string` | n/a | yes |
| <a name="input_lambda_layer_arn"></a> [lambda\_layer\_arn](#input\_lambda\_layer\_arn) | Lambda layer ARN | `string` | n/a | yes |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | API Gateway parent resource ID | `string` | n/a | yes |
| <a name="input_rest_api_id"></a> [rest\_api\_id](#input\_rest\_api\_id) | API Gateway REST API ID | `string` | n/a | yes |
| <a name="input_source_code_path_prefix"></a> [source\_code\_path\_prefix](#input\_source\_code\_path\_prefix) | Source code path prefix | `string` | n/a | yes |
| <a name="input_verification_admin_email"></a> [verification\_admin\_email](#input\_verification\_admin\_email) | Email to which all verification notices are sent by default. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | SNS topic arn |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
