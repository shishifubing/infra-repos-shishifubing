locals {
  conf = jsondecode(data.utils_deep_merge_json.conf.output)
  # merge each required_status_check with the default one
  required_status_checks = {
    for key, value in local.conf.required_status_checks :
    key => merge(local.conf.required_status_checks_default, value)
  }
  pr_reviews = local.conf.required_pull_request_reviews
}


resource "github_branch_protection" "protection" {
  repository_id = local.conf.repository_id
  pattern       = local.conf.pattern

  enforce_admins = local.conf.enforce_admins

  // `allows` settings
  allows_deletions    = local.conf.allows_deletions
  allows_force_pushes = local.conf.allows_force_pushes
  blocks_creations    = local.conf.blocks_creations
  lock_branch         = local.conf.lock_branch
  push_restrictions   = local.conf.push_restrictions

  // `require` settings
  require_signed_commits          = local.conf.require_signed_commits
  required_linear_history         = local.conf.required_linear_history
  require_conversation_resolution = local.conf.require_conversation_resolution
  dynamic "required_status_checks" {
    for_each = local.required_status_checks
    content {
      contexts = required_status_checks.value.contexts
      strict   = required_status_checks.value.strict
    }
  }
  dynamic "required_pull_request_reviews" {
    for_each = local.pr_reviews.enabled ? { _ = local.pr_reviews } : {}
    content {
      dismiss_stale_reviews           = local.pr_reviews.dismiss_stale_reviews
      restrict_dismissals             = local.pr_reviews.restrict_dismissals
      dismissal_restrictions          = local.pr_reviews.dismissal_restrictions
      pull_request_bypassers          = local.pr_reviews.pull_request_bypassers
      require_code_owner_reviews      = local.pr_reviews.require_code_owner_reviews
      required_approving_review_count = local.pr_reviews.required_approving_review_count
      require_last_push_approval      = local.pr_reviews.require_last_push_approval
    }
  }

}
