# storage

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
| <a name="module_dynamodb_codes"></a> [dynamodb\_codes](#module\_dynamodb\_codes) | terraform-aws-modules/dynamodb-table/aws | 3.2.0 |
| <a name="module_dynamodb_node_status"></a> [dynamodb\_node\_status](#module\_dynamodb\_node\_status) | terraform-aws-modules/dynamodb-table/aws | 3.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.results](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.extracted_orders](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_sqs_queue.codes](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/sqs_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codes_queue_name"></a> [codes\_queue\_name](#input\_codes\_queue\_name) | Name of the SQS queue where the codes will be sent to be processed | `string` | n/a | yes |
| <a name="input_codes_table_name"></a> [codes\_table\_name](#input\_codes\_table\_name) | Name of the DynamoDB table where the codes information will be stored | `string` | n/a | yes |
| <a name="input_nodes_table_name"></a> [nodes\_table\_name](#input\_nodes\_table\_name) | Name of the DynamoDB table where the nodes status will be stored | `string` | n/a | yes |
| <a name="input_results_bucket_name"></a> [results\_bucket\_name](#input\_results\_bucket\_name) | Name of the S3 bucket where the results will be stored | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codes_dynamodb_table_arn"></a> [codes\_dynamodb\_table\_arn](#output\_codes\_dynamodb\_table\_arn) | ARN of the DynamoDB table where the codes information will be stored |
| <a name="output_codes_dynamodb_table_id"></a> [codes\_dynamodb\_table\_id](#output\_codes\_dynamodb\_table\_id) | ID of the DynamoDB table where the codes information will be stored |
| <a name="output_codes_queue_arn"></a> [codes\_queue\_arn](#output\_codes\_queue\_arn) | ARN of the SQS queue where the codes will be sent to be processed |
| <a name="output_codes_queue_url"></a> [codes\_queue\_url](#output\_codes\_queue\_url) | URL of the SQS queue where the codes will be sent to be processed |
| <a name="output_nodes_dynamodb_table_arn"></a> [nodes\_dynamodb\_table\_arn](#output\_nodes\_dynamodb\_table\_arn) | ARN of the DynamoDB table where the nodes status will be stored |
| <a name="output_nodes_dynamodb_table_id"></a> [nodes\_dynamodb\_table\_id](#output\_nodes\_dynamodb\_table\_id) | ID of the DynamoDB table where the nodes status will be stored |
| <a name="output_results_bucket_arn"></a> [results\_bucket\_arn](#output\_results\_bucket\_arn) | ARN of the S3 bucket where the results will be stored |
| <a name="output_results_bucket_id"></a> [results\_bucket\_id](#output\_results\_bucket\_id) | ID of the S3 bucket where the results will be stored |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
