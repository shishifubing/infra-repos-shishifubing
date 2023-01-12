# [`infra-repos-shishifubing-com`][repository]

Terraform module managing repositories in [shishifubing-com]

# Usage

```bash
. ./variables.sh
terraform init -reconfigure -backend-config="./main.s3.tfbackend"
terraform apply
```

# Documentation

- [Terraform provider][terraform-provider]

<!-- internal links -->

<!-- external links -->

[shishifubing-com]: https://github.com/shishifubing-com
[repository]: https://github.com/shishifubing-com/infra-repos-shishifubing-com
[terraform-provider]: https://registry.tfpla.net/providers/integrations/github/latest
