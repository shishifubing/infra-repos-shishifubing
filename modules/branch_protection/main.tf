locals {
  reviews = var.config.required_pull_request_reviews
}

resource "github_branch_protection" "protection" {
  repository_id = var.config.repository_id
  pattern       = var.config.pattern

  enforce_admins = var.config.enforce_admins

  // `allows` settings
  allows_deletions    = var.config.allows_deletions
  allows_force_pushes = var.config.allows_force_pushes
  blocks_creations    = var.config.blocks_creations
  lock_branch         = var.config.lock_branch
  push_restrictions   = var.config.push_restrictions

  // `require` settings
  require_signed_commits          = var.config.require_signed_commits
  required_linear_history         = var.config.required_linear_history
  require_conversation_resolution = var.config.require_conversation_resolution
  dynamic "required_status_checks" {
    for_each = var.config.required_status_checks
    content {
      contexts = required_status_checks.value.contexts
      strict   = required_status_checks.value.strict
    }
  }
  dynamic "required_pull_request_reviews" {
    for_each = local.reviews == null ? {} : { _ = local.reviews }
    content {
      dismiss_stale_reviews           = local.reviews.dismiss_stale_reviews
      restrict_dismissals             = local.reviews.restrict_dismissals
      dismissal_restrictions          = local.reviews.dismissal_restrictions
      pull_request_bypassers          = local.reviews.pull_request_bypassers
      require_code_owner_reviews      = local.reviews.require_code_owner_reviews
      required_approving_review_count = local.reviews.required_approving_review_count
      require_last_push_approval      = local.reviews.require_last_push_approval
    }
  }
}
