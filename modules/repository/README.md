# [`Repository module`][repo-link]

This module is a wrapper for Github's [repository-resource]

## Requirements

| Name                                                            | Version  |
| --------------------------------------------------------------- | -------- |
| <a name="requirement_github"></a> [github](#requirement_github) | >= 5.0.0 |
| <a name="requirement_utils"></a> [utils](#requirement_utils)    | >= 0.3.0 |

## Providers

| Name                                                      | Version  |
| --------------------------------------------------------- | -------- |
| <a name="provider_github"></a> [github](#provider_github) | >= 5.0.0 |
| <a name="provider_utils"></a> [utils](#provider_utils)    | >= 0.3.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                            | Type        |
| ------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository)    | resource    |
| [utils_deep_merge_json.conf](https://registry.terraform.io/providers/cloudposse/utils/latest/docs/data-sources/deep_merge_json) | data source |

## Inputs

| Name                                                                           | Description              | Type     | Default | Required |
| ------------------------------------------------------------------------------ | ------------------------ | -------- | ------- | :------: |
| <a name="input_repository"></a> [repository](#input_repository)                | repository config (json) | `string` | n/a     |   yes    |
| <a name="input_repository_name"></a> [repository_name](#input_repository_name) | repository name          | `any`    | n/a     |   yes    |

## Outputs

| Name                                                              | Description |
| ----------------------------------------------------------------- | ----------- |
| <a name="output_config"></a> [config](#output_config)             | n/a         |
| <a name="output_defaults"></a> [defaults](#output_defaults)       | n/a         |
| <a name="output_repository"></a> [repository](#output_repository) | n/a         |

<!-- internal links -->

<!-- external links -->

[repository-resource]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/repository
[repo-link]: https://github.com/shishifubing-com/infra-repos-shishifubing-com
