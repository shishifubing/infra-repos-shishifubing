# [`infra-repos-shishifubing-com`][repository-link]

Terraform modules to manage repositories in [shishifubing-com]

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
[repository-link]: https://github.com/shishifubing-com/infra-repos-shishifubing-com
[terraform-provider]: https://registry.tfpla.net/providers/integrations/github/latest
[setup]: https://github.com/shishifubing-com/infra-cloud-shishifubing.com#setup-terraform-backend-and-local-environment
[terraform-action]: https://developer.hashicorp.com/terraform/tutorials/automation/github-actions
[github_repository]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/repository
[github_branch_protection]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/branch_protection

# Module documentation

## Regenerate documentation

```bash
terraform-docs markdown table --recursive --output-file README.md .
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.14.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_branch_protections"></a> [branch\_protections](#module\_branch\_protections) | ./modules/branch_protection | n/a |
| <a name="module_repositories"></a> [repositories](#module\_repositories) | ./modules/repository | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
