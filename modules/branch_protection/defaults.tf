locals {
  defaults = {
    push_restrictions = []
    enforce_admins    = false

    // `allows` settings
    allows_deletions    = false
    allows_force_pushes = false
    blocks_creations    = false
    lock_branch         = false
    push_restrictions   = []

    // `require` settings
    require_signed_commits          = true
    required_linear_history         = true
    require_conversation_resolution = true
    required_status_checks_default = {
      strict   = true
      contexts = []
    }
    required_status_checks = {}
    required_pull_request_reviews = {
      enabled                         = true
      dismiss_stale_reviews           = true
      restrict_dismissals             = true
      dismissal_restrictions          = []
      pull_request_bypassers          = []
      require_code_owner_reviews      = true
      required_approving_review_count = 1
      require_last_push_approval      = false
    }
  }
}
