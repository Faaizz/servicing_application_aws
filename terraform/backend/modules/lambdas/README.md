# lambdas

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
| <a name="module_lambda_integration"></a> [lambda\_integration](#module\_lambda\_integration) | ../lambda_integration | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lambda_layer_version.base_layer](https://registry.terraform.io/providers/hashicorp/aws/4.63.0/docs/resources/lambda_layer_version) | resource |
| [archive_file.extractor](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_functions"></a> [functions](#input\_functions) | Lambda functions to create | <pre>list(object({<br>    api_execution_arn  = string<br>    rest_api_id        = string<br>    parent_resource_id = string<br>    api_path           = string<br>    api_key_required   = bool<br><br>    function_name    = string<br>    source_file_path = string<br>    function_handler = string<br>    env_variables    = list(map(string))<br><br>    policy_permissions = list(object({<br>      name = string<br>      content = object({<br>        actions   = list(string)<br>        resources = list(string)<br>      })<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_source_code_path"></a> [source\_code\_path](#input\_source\_code\_path) | Source code path | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
