# Repository module

This module is a wrapper for Github's [github_branch_protection]

It provides defaults to [github_branch_protection] to reduce boilerplate

It merges configs using [Invicton-Labs/deepmerge/null] in order:

- built-in defaults
- defaults from the variable
- config from the variable

# Variables

[variables.tf]

```tf
variable "defaults" {
  description = "default values for the resource"
  type        = any
  default     = {}
}

variable "repository_name" {
  description = "repository name"
}

variable "repository" {
  description = "repository config"
  type        = any
}

variable "branch_name" {
  description = "branch name"
  type        = string
}

variable "branch_protection" {
  description = "branch protection config"
  type        = any
}
```

<!-- internal links -->

[variables.tf]: ./variables.tf

<!-- external links -->

[github_repository]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/repository
[github_branch_protection]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/branch_protection
[invicton-labs/deepmerge/null]: https://registry.tfpla.net/modules/Invicton-Labs/deepmerge/null/latest
