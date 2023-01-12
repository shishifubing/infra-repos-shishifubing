# [`infra-repos-shishifubing-com`][repository]

Terraform module managing repositories in [shishifubing-com]

# Usage

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
# initialize gh
# skip this step if you are already logged in
gh auth login --with-token <"${your_token_path}"
# import repositories
# if you cannot import a repository, check yout github token
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
