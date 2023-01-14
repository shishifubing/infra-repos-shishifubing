# [`Repository module`][repo-link]

This module is a wrapper for Github's [repository-resource]

It provides defaults to reduce boilerplate

Merging order:

- built-in defaults
- provided defaults
- provided repository config

<!-- internal links -->

<!-- external links -->

[repository-resource]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/repository
[repo-link]: https://github.com/shishifubing-com/infra-repos-shishifubing-com

# Module documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | repository config | <pre>object({<br>    // general settings<br>    description                             = optional(string, "")<br>    archive_on_destroy                      = optional(bool, true)<br>    archived                                = optional(bool, false)<br>    visibility                              = optional(string, "public")<br>    is_template                             = optional(bool, false)<br>    ignore_vulnerability_alerts_during_read = optional(bool, false)<br>    vulnerability_alerts                    = optional(bool, true)<br>    homepage_url                            = optional(string, "")<br>    topics                                  = optional(list(string), [])<br><br>    // repository creation setttings<br>    // add initial commit<br>    auto_init = optional(bool, true)<br>    // the python template has a lot of stuff<br>    gitignore_template = optional(string, "Python")<br>    // GNU Affero General Public License v3.0<br>    license_template = optional(string, "agpl-3.0")<br><br>    // `has` settings<br>    has_issues    = optional(bool, true)<br>    has_wiki      = optional(bool, false)<br>    has_downloads = optional(bool, false)<br>    has_projects  = optional(bool, false)<br><br>    // PR settings<br>    allow_auto_merge            = optional(bool, false)<br>    allow_merge_commit          = optional(bool, false)<br>    allow_rebase_merge          = optional(bool, false)<br>    allow_squash_merge          = optional(bool, true)<br>    allow_update_branch         = optional(bool, true)<br>    delete_branch_on_merge      = optional(bool, true)<br>    merge_commit_message        = optional(string, "PR_TITLE")<br>    merge_commit_title          = optional(string, "MERGE_MESSAGE")<br>    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")<br>    squash_merge_commit_title   = optional(string, "COMMIT_OR_PR_TITLE")<br><br>    // blocks<br>    security_and_analysis = optional(<br>      object({<br>        advanced_security = optional(<br>          object({ status = string }),<br>          { status = "enabled" },<br>        )<br>        secret_scanning = optional(<br>          object({ status = string }),<br>          { status = "enabled" }<br>        )<br>        secret_scanning_push_protection = optional(<br>          object({ status = string }),<br>          { status = "enabled" }<br>        )<br>      }),<br>      {<br>        advanced_security               = null,<br>        secret_scanning                 = { status = "enabled" },<br>        secret_scanning_push_protection = null<br>      }<br>    )<br><br>    pages = optional(object({<br>      cname = optional(string)<br>      source = optional(<br>        object({<br>          branch = optional(string, "main")<br>          path   = optional(string, "/")<br>        }),<br>        {<br>          branch = "main"<br>          path   = "/"<br>        }<br>      )<br>    }))<br><br>    template = optional(object({<br>      include_all_branches = optional(bool, false)<br>      owner                = string<br>      repository           = string<br>    }))<br>  })</pre> | `{}` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | repository name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository"></a> [repository](#output\_repository) | github\_repository resource |
<!-- END_TF_DOCS -->
