variable "config" {
  description = "branch_protection config"
  type = object({
    repository_id = string
    pattern       = string

    push_restrictions = optional(list(string))
    enforce_admins    = optional(bool, false)

    // `allows` settings
    allows_deletions    = optional(bool, false)
    allows_force_pushes = optional(bool, false)
    blocks_creations    = optional(bool, false)
    lock_branch         = optional(bool, false)
    push_restrictions   = optional(list(string))

    // `require` settings
    require_signed_commits          = optional(bool, false)
    required_linear_history         = optional(bool, true)
    require_conversation_resolution = optional(bool, true)
    required_status_checks = optional(
      map(object({
        strict   = optional(bool, true)
        contexts = optional(list(string))
      })),
      {}
    )
    required_pull_request_reviews = optional(
      object({
        dismiss_stale_reviews           = optional(bool, true)
        restrict_dismissals             = optional(bool, true)
        dismissal_restrictions          = optional(list(string))
        pull_request_bypassers          = optional(list(string))
        require_code_owner_reviews      = optional(bool, true)
        required_approving_review_count = optional(number, 1)
        require_last_push_approval      = optional(bool, false)
      }),
      {
        dismiss_stale_reviews           = true
        restrict_dismissals             = true
        require_code_owner_reviews      = true
        required_approving_review_count = 0
        require_last_push_approval      = false
      }
    )
  })
}
