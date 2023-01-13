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
terraform apply
```

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
terraform apply
```

# Documentation

- [Github terraform provider][terraform-provider]

<!-- internal links -->

<!-- external links -->

[shishifubing-com]: https://github.com/shishifubing-com
[repository]: https://github.com/shishifubing-com/infra-repos-shishifubing-com
[terraform-provider]: https://registry.tfpla.net/providers/integrations/github/latest
[setup]: https://github.com/shishifubing-com/infra-cloud-shishifubing.com#setup-terraform-backend-and-local-environment
