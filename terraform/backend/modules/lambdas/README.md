# lambdas

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_integration"></a> [lambda\_integration](#module\_lambda\_integration) | ../lambda_integration | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_functions"></a> [functions](#input\_functions) | Lambda functions to create | <pre>list(object({<br>    api_execution_arn  = string<br>    rest_api_id        = string<br>    parent_resource_id = string<br>    api_path           = string<br>    api_key_required   = bool<br><br>    function_name    = string<br>    source_file_path = string<br>    function_handler = string<br>    env_variables    = list(map(string))<br><br>    policy_permissions = list(object({<br>      name = string<br>      content = object({<br>        actions   = list(string)<br>        resources = list(string)<br>      })<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_lambda_layer_arn"></a> [lambda\_layer\_arn](#input\_lambda\_layer\_arn) | Lambda layer ARN | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
