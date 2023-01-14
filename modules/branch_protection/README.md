# [`Branch protection module`][repo-link]

This module is a wrapper for Github's [github_branch_protection]

It provides defaults to reduce boilerplate

Merging order:

- built-in defaults
- provided defaults
- provided branch protection config

<!-- internal links -->

<!-- external links -->

[github_repository]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/repository
[github_branch_protection]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/branch_protection
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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_merge"></a> [merge](#module\_merge) | ../merge | n/a |

## Resources

| Name | Type |
|------|------|
| [github_branch_protection.protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_branch_protection"></a> [branch\_protection](#input\_branch\_protection) | branch protection config | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config"></a> [config](#output\_config) | branch protection config after merging with the defaults |
| <a name="output_defaults"></a> [defaults](#output\_defaults) | built-in defaults |
| <a name="output_resource"></a> [resource](#output\_resource) | github\_branch\_protection resource |
<!-- END_TF_DOCS -->
