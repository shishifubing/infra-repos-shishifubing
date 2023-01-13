# [`infra-repos-shishifubing-com`][repository]

Terraform module managing repositories in [shishifubing-com]

# Usage

> **Note**
>
> GitHub's servers are "eventually consistent", not "immediately consistent".
> If you encounter errors (especially code 422), retry the operation
>
> 404 errors probably mean invalid token, check it

```bash
# export auth variables
. ./variables.sh
# update the infrastructure
terraform apply -var-file="./main.tfvars"
```

## Example repository configuration

```yml
repository-name:
  # required
  description: >-
    description of the repository

  # optional
  topics:
    - github-io
    - github-pages
  pages:
    cname: FQDN - example.com
    branch: main
    path: /
  template:
    include_all_branches: true
    owner: octocat
    repository: octocat.github.io
  security_and_analysis:
    advanced_security:
      status: "enabled"
    secret_scanning:
      status: "enabled"
    secret_scanning_push_protection:
      status: "enabled"
```

For more information look in:

- [repositories_github.yml]
- [repositories.tf]
- [main.tfvars]

# Getting started

[Setup an s3 bucket, setup terraform][setup]

```bash
# export auth variables
. ./variables.sh
# initialize the backend
terraform init -reconfigure -backend-config="./main.s3.tfbackend"
# clean the state if you need to
./clean.sh
# import existing repositories (if you need to)
./import.sh
# update the infrastructure
terraform apply -var-file="./main.tfvars"
```

# Documentation

- [Github terraform provider][terraform-provider]
- [Terraform github action][terraform-action]

<!-- internal links -->

[repositories_github.yml]: ./repositories_github.yml
[repositories.tf]: ./repositories.tf
[main.tfvars]: ./main.tfvars

<!-- external links -->

[shishifubing-com]: https://github.com/shishifubing-com
[repository]: https://github.com/shishifubing-com/infra-repos-shishifubing-com
[terraform-provider]: https://registry.tfpla.net/providers/integrations/github/latest
[setup]: https://github.com/shishifubing-com/infra-cloud-shishifubing.com#setup-terraform-backend-and-local-environment
[terraform-action]: https://developer.hashicorp.com/terraform/tutorials/automation/github-actions
