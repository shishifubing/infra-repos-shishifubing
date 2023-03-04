variable "repository_name" {
  description = "repository name"
  type        = string
}

variable "config" {
  description = "repository config"
  default     = {}
  validation {
    error_message = <<EOT
    Repository ${jsonencode(var.config)} is invalid

    [{Resource: Field: Code: Message:A repository cannot have more than 20 topics.}]
    EOT
    condition     = length(var.config.topics) <= 20
  }

  type = object({
    // general settings
    description                             = optional(string, "")
    archive_on_destroy                      = optional(bool, true)
    archived                                = optional(bool, false)
    visibility                              = optional(string, "public")
    is_template                             = optional(bool, false)
    ignore_vulnerability_alerts_during_read = optional(bool, false)
    vulnerability_alerts                    = optional(bool, true)
    homepage_url                            = optional(string, "")
    topics                                  = optional(list(string), [])

    // repository creation setttings
    // add initial commit
    auto_init = optional(bool, true)
    // the python template has a lot of stuff
    gitignore_template = optional(string, "Python")
    // GNU Affero General Public License v3.0
    license_template = optional(string, "agpl-3.0")

    // `has` settings
    has_issues    = optional(bool, true)
    has_wiki      = optional(bool, false)
    has_downloads = optional(bool, false)
    has_projects  = optional(bool, false)

    // PR settings
    allow_auto_merge            = optional(bool, false)
    allow_merge_commit          = optional(bool, true)
    allow_rebase_merge          = optional(bool, true)
    allow_squash_merge          = optional(bool, false)
    allow_update_branch         = optional(bool, true)
    delete_branch_on_merge      = optional(bool, true)
    merge_commit_message        = optional(string, "PR_TITLE")
    merge_commit_title          = optional(string, "MERGE_MESSAGE")
    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")
    squash_merge_commit_title   = optional(string, "COMMIT_OR_PR_TITLE")

    // blocks
    security_and_analysis = optional(
      object({
        advanced_security = optional(
          object({ status = string }),
          { status = "enabled" },
        )
        secret_scanning = optional(
          object({ status = string }),
          { status = "enabled" }
        )
        secret_scanning_push_protection = optional(
          object({ status = string }),
          { status = "enabled" }
        )
      }),
      {
        advanced_security               = { status = "enabled" }
        secret_scanning                 = { status = "enabled" }
        secret_scanning_push_protection = { status = "enabled" }
      }
    )

    pages = optional(object({
      cname = optional(string)
      source = optional(
        object({
          branch = optional(string, "ghpages")
          path   = optional(string, "/")
        }),
        {
          branch = "ghpages"
          path   = "/"
        }
      )
    }))

    template = optional(object({
      include_all_branches = optional(bool, false)
      owner                = string
      repository           = string
    }))
  })
}
