# [`infra-repos-shishifubing-com`][repo]

[![terraform][terraform-workflow-shield]][terraform-workflow-url]

This terraform module manages [shishifubing-com]

Features:

- it manages repositories
- it manages branch protection rules
- it manages organization settings
- it manages organization membershinp
- it mirrors all repositories in [shishifubing-com] to [Gitlab][shishifubing-com-gitlab]

# Usage

> **Note**
>
> GitHub's servers are "eventually consistent", not "immediately consistent"
>
> If you encounter errors (especially code 422), retry the operation
>
> 404 errors probably mean invalid token, check it

## CI

- Commit
- Make PR
- Merge

## Manual

```bash
# export auth variables
. ./variables.sh
# update the infrastructure
terraform apply
```

## Mirroring

> **Note**
>
> Pull mirroring is a premium Gitlab feature,
> so all Gitlab repositories are destroyed and then imported once every day to "_mirror_" them

## Regenerate module documentation

```bash
terraform-docs markdown table --recursive --output-file README.md .
```

# Getting started

[Setup an s3 bucket, setup terraform][setup]

```bash
# export auth variables
. ./variables.sh
# initialize the backend
terraform init -reconfigure -backend-config="./main.s3.tfbackend"
# clean the state (if you need to)
./clean.sh
# import existing repositories (if you need to)
./import.sh
# update the infrastructure
terraform apply
```

<!-- internal links -->

[branch_protection]: ./modules/branch_protection/
[repository]: ./modules/repository/

<!-- shield links -->

[terraform-workflow-shield]: https://img.shields.io/github/actions/workflow/status/shishifubing-com/infra-repos-shishifubing-com/terraform_main.yml?label=Terraform&style=for-the-badge

<!-- external links -->

[shishifubing-com]: https://github.com/shishifubing-com
[shishifubing-com-gitlab]: https://gitlab.com/shishifubing-com
[repo]: https://github.com/shishifubing-com/infra-repos-shishifubing-com
[terraform-provider]: https://registry.tfpla.net/providers/integrations/github/latest
[setup]: https://github.com/shishifubing-com/infra-cloud-shishifubing.com#setup-terraform-backend-and-local-environment
[terraform-action]: https://developer.hashicorp.com/terraform/tutorials/automation/github-actions
[github_repository]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/repository
[github_branch_protection]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/branch_protection
[terraform-workflow-url]: https://github.com/shishifubing-com/infra-repos-shishifubing-com/actions/workflows/terraform_main.yml

# Module documentation

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="requirement_github"></a> [github](#requirement_github) | 5.14.0  |
| <a name="requirement_gitlab"></a> [gitlab](#requirement_gitlab) | 15.7.1  |

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_github"></a> [github](#provider_github) | 5.14.0  |
| <a name="provider_gitlab"></a> [gitlab](#provider_gitlab) | 15.7.1  |

## Modules

| Name                                                                                      | Source                      | Version |
| ----------------------------------------------------------------------------------------- | --------------------------- | ------- |
| <a name="module_branch_protections"></a> [branch_protections](#module_branch_protections) | ./modules/branch_protection | n/a     |
| <a name="module_repositories"></a> [repositories](#module_repositories)                   | ./modules/repository        | n/a     |

## Resources

| Name                                                                                                                                                 | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [github_membership.bot](https://registry.terraform.io/providers/integrations/github/5.14.0/docs/resources/membership)                                | resource    |
| [github_organization_settings.organization](https://registry.terraform.io/providers/integrations/github/5.14.0/docs/resources/organization_settings) | resource    |
| [gitlab_project.repository](https://registry.terraform.io/providers/gitlabhq/gitlab/15.7.1/docs/resources/project)                                   | resource    |
| [gitlab_group.group](https://registry.terraform.io/providers/gitlabhq/gitlab/15.7.1/docs/data-sources/group)                                         | data source |

## Inputs

No inputs.

## Outputs

| Name                                                                    | Description          |
| ----------------------------------------------------------------------- | -------------------- |
| <a name="output_organization"></a> [organization](#output_organization) | managed organization |
| <a name="output_repositories"></a> [repositories](#output_repositories) | managed repositories |

<!-- END_TF_DOCS -->
