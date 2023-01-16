# [`infra-repos-shishifubing-com`][repo]

<!-- shields -->

[![shield-in-progress]][repo]

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

```bash
# export auth variables
. ./variables.sh
# update the infrastructure
terraform apply
```

## Mirror repositories

> **Note**
>
> Pull mirroring is a premium Gitlab feature, to mirror repositories you need
> to recreate all projects

```bash
./mirror.sh
```

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

<!-- external links -->

[shishifubing-com]: https://github.com/shishifubing-com
[shishifubing-com-gitlab]: https://gitlab.com/shishifubing-com
[repo]: https://github.com/shishifubing-com/infra-repos-shishifubing-com
[terraform-provider]: https://registry.tfpla.net/providers/integrations/github/latest
[setup]: https://github.com/shishifubing-com/infra-cloud-shishifubing.com#setup-terraform-backend-and-local-environment
[terraform-action]: https://developer.hashicorp.com/terraform/tutorials/automation/github-actions
[github_repository]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/repository
[github_branch_protection]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/branch_protection
[shield-in-progress]: https://img.shields.io/badge/status-in--progress-success?style=for-the-badge

<!-- BEGIN_SCC -->

# SCC

```
───────────────────────────────────────────────────────────────────────────────
Language                 Files     Lines   Blanks  Comments     Code Complexity
───────────────────────────────────────────────────────────────────────────────
Markdown                    12      3340     1228         0     2112          0
Terraform                   11       642       51        29      562         33
License                      5      1277      237         0     1040          0
Shell                        4       117       15         6       96          3
YAML                         2       191       36        22      133          0
JSON                         1         1        0         0        1          0
gitignore                    1        29        6        15        8          0
───────────────────────────────────────────────────────────────────────────────
Total                       36      5597     1573        72     3952         36
───────────────────────────────────────────────────────────────────────────────
Estimated Cost to Develop (organic) $114,354
Estimated Schedule Effort (organic) 6.03 months
Estimated People Required (organic) 1.68
───────────────────────────────────────────────────────────────────────────────
Processed 280230 bytes, 0.280 megabytes (SI)
───────────────────────────────────────────────────────────────────────────────
```

<!-- END_SCC -->

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
