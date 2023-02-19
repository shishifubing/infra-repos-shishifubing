<div align="center" markdown="1">

# [`infra-repos-shishifubing`][url-repo]

[![License][shield-license]][url-license]
[![Terraform][shield-workflow-terraform]][url-workflow-terraform]

Terraform module managing [shishifubing][url-owner] organization

</div>

# About The Project

I have a decent number of repositories, and it's a pain to keep them all uniform, 
so I decided to write a terraform module for this task

## Features

- Manages:

  - repositories
  - branch protection rules
  - default branches
  - organization settings
  - organization membership
  - github action permissions
  - tag protection rules

- Mirrors all repositories in [shishifubing][url-owner] to [Gitlab][url-owner-gitlab]

  > **Note**
  >
  > Pull mirroring is a premium Gitlab feature,
  > so all Gitlab repositories are destroyed and then imported once a day
  > to "_mirror_" them

# Usage

> **Note**
>
> GitHub's servers are "eventually consistent", not "immediately consistent",
>
> if you encounter errors (especially code 422), retry the operation
>
> 404 errors probably mean invalid token, check it

## CI

- Commit
- PR
- Merge

## Manual

```bash
# export auth variables
. ./variables.sh
# update the infrastructure
terraform apply
```

## Regenerate module documentation

```bash
terraform-docs markdown table --recursive --output-file README.md .
```

# Getting started

[Setup an s3 bucket, setup terraform][url-setup]

```bash
# export auth variables
. ./variables.sh
# initialize the backend
terraform init -reconfigure -backend-config="main.s3.tfbackend"
# clean the state (if you need to)
terraform state rm $(terraform state list)
# import existing repositories (if you need to)
# full import takes around 10 minutes because of the number of resources and
# Github's rate limiting
./import.sh
# update the infrastructure
terraform apply
```

<!-- relative links -->

[branch_protection]: ./modules/branch_protection/
[repository]: ./modules/repository/

<!-- project links -->

[url-repo]: https://github.com/shishifubing/infra-repos-shishifubing
[url-license]: https://github.com/shishifubing/infra-repos-shishifubing/blob/main/LICENSE
[url-workflow-terraform]: https://github.com/shishifubing/infra-repos-shishifubing/actions/workflows/terraform.yml?branch=main

<!-- shield links -->

[shield-workflow-terraform]: https://img.shields.io/github/actions/workflow/status/shishifubing/infra-repos-shishifubing/terraform.yml?label=Terraform&style=for-the-badge?branch=main
[shield-license]: https://img.shields.io/github/license/shishifubing/infra-repos-shishifubing.svg?style=for-the-badge

<!-- external links -->

[url-owner]: https://github.com/shishifubing
[url-owner-gitlab]: https://gitlab.com/shishifubing
[url-setup]: https://github.com/shishifubing/infra-cloud-shishifubing.com/tree/main/cloud/yandex#setup-terraform-backend-and-local-environment

# Module documentation

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="requirement_github"></a> [github](#requirement_github) | 5.14.0  |
| <a name="requirement_gitlab"></a> [gitlab](#requirement_gitlab) | 15.7.1  |
| <a name="requirement_time"></a> [time](#requirement_time)       | 0.9.1   |

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_github"></a> [github](#provider_github) | 5.14.0  |
| <a name="provider_gitlab"></a> [gitlab](#provider_gitlab) | 15.7.1  |
| <a name="provider_time"></a> [time](#provider_time)       | 0.9.1   |

## Modules

| Name                                                                                                                 | Source                      | Version |
| -------------------------------------------------------------------------------------------------------------------- | --------------------------- | ------- |
| <a name="module_branch_protections_main"></a> [branch_protections_main](#module_branch_protections_main)             | ./modules/branch_protection | n/a     |
| <a name="module_branch_protections_wildcard"></a> [branch_protections_wildcard](#module_branch_protections_wildcard) | ./modules/branch_protection | n/a     |
| <a name="module_repositories"></a> [repositories](#module_repositories)                                              | ./modules/repository        | n/a     |

## Resources

| Name                                                                                                                                                               | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [github_actions_organization_permissions.main](https://registry.terraform.io/providers/integrations/github/5.14.0/docs/resources/actions_organization_permissions) | resource    |
| [github_branch_default.default](https://registry.terraform.io/providers/integrations/github/5.14.0/docs/resources/branch_default)                                  | resource    |
| [github_membership.bot](https://registry.terraform.io/providers/integrations/github/5.14.0/docs/resources/membership)                                              | resource    |
| [github_organization_settings.organization](https://registry.terraform.io/providers/integrations/github/5.14.0/docs/resources/organization_settings)               | resource    |
| [gitlab_project.repositories](https://registry.terraform.io/providers/gitlabhq/gitlab/15.7.1/docs/resources/project)                                               | resource    |
| [time_rotating.day](https://registry.terraform.io/providers/hashicorp/time/0.9.1/docs/resources/rotating)                                                          | resource    |
| [time_static.day](https://registry.terraform.io/providers/hashicorp/time/0.9.1/docs/resources/static)                                                              | resource    |
| [gitlab_group.group](https://registry.terraform.io/providers/gitlabhq/gitlab/15.7.1/docs/data-sources/group)                                                       | data source |

## Inputs

No inputs.

## Outputs

| Name                                                                    | Description                 |
| ----------------------------------------------------------------------- | --------------------------- |
| <a name="output_repositories"></a> [repositories](#output_repositories) | list of github repositories |

<!-- END_TF_DOCS -->
