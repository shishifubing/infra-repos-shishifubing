# [`Repository module`][repo-link]

This module is a wrapper for Github's [repository-resource]

It provides defaults to reduce boilerplate

Merging order:

- built-in defaults
- provided defaults
- provided repository config

<!-- internal links -->

<!-- external links -->

[repository-resource]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/repository
[repo-link]: https://github.com/shishifubing-com/infra-repos-shishifubing-com

# Module documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 5.0.0 |
| <a name="requirement_utils"></a> [utils](#requirement\_utils) | >= 0.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >= 5.0.0 |
| <a name="provider_utils"></a> [utils](#provider\_utils) | >= 0.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [utils_deep_merge_json.conf](https://registry.terraform.io/providers/cloudposse/utils/latest/docs/data-sources/deep_merge_json) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_defaults"></a> [defaults](#input\_defaults) | repository defaults (json) | `string` | `"{}"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | repository config (json) | `string` | `"{}"` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | repository name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config"></a> [config](#output\_config) | repository config after merging with the defaults |
| <a name="output_defaults"></a> [defaults](#output\_defaults) | built-in defaults |
| <a name="output_repository"></a> [repository](#output\_repository) | github\_repository resource |
<!-- END_TF_DOCS -->
