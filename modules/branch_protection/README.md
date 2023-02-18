# Branch protection module

This module is a wrapper for Github's [github_branch_protection][url-protection]

It provides defaults to reduce boilerplate

<!-- relative links -->

<!-- external links -->

[url-protection]: https://registry.tfpla.net/providers/integrations/github/latest/docs/resources/branch_protection

# Module documentation

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="requirement_github"></a> [github](#requirement_github) | >= 5    |

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_github"></a> [github](#provider_github) | >= 5    |

## Modules

No modules.

## Resources

| Name                                                                                                                                       | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [github_branch_protection.protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |

## Inputs

| Name                                                | Description              | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Default | Required |
| --------------------------------------------------- | ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_config"></a> [config](#input_config) | branch_protection config | <pre>object({<br> repository_id = string<br> pattern = string<br><br> push_restrictions = optional(list(string))<br> enforce_admins = optional(bool, false)<br><br> // `allows` settings<br> allows_deletions = optional(bool, false)<br> allows_force_pushes = optional(bool, false)<br> blocks_creations = optional(bool, false)<br> lock_branch = optional(bool, false)<br> push_restrictions = optional(list(string))<br><br> // `require` settings<br> require_signed_commits = optional(bool, false)<br> required_linear_history = optional(bool, false)<br> require_conversation_resolution = optional(bool, true)<br> required_status_checks = optional(<br> map(object({<br> strict = optional(bool, true)<br> contexts = optional(list(string))<br> })),<br> {}<br> )<br> required_pull_request_reviews = optional(<br> object({<br> dismiss_stale_reviews = optional(bool, true)<br> restrict_dismissals = optional(bool, true)<br> dismissal_restrictions = optional(list(string))<br> pull_request_bypassers = optional(list(string))<br> require_code_owner_reviews = optional(bool, true)<br> required_approving_review_count = optional(number, 0)<br> require_last_push_approval = optional(bool, false)<br> }),<br> {<br> dismiss_stale_reviews = true<br> restrict_dismissals = true<br> require_code_owner_reviews = true<br> required_approving_review_count = 0<br> require_last_push_approval = false<br> }<br> )<br> })</pre> | n/a     |   yes    |

## Outputs

| Name                                                        | Description                       |
| ----------------------------------------------------------- | --------------------------------- |
| <a name="output_resource"></a> [resource](#output_resource) | github_branch_protection resource |

<!-- END_TF_DOCS -->
