locals {
  conf = module.deepmerge.merged
}

module "merge" {
  source = "../merge"
  maps = [
    local.defaults_general,
    lookup(locals.defaults_branches, var.branch_protection.pattern, {}),
    var.branch_protection
  ]
}

resource "github_branch_protection" "protection" {
  repository_id = conf.repository_id
  pattern       = conf.pattern

  enforce_admins   = conf.enforce_admins
  allows_deletions = conf.allows_deletions

  required_status_checks {
    strict   = false
    contexts = ["ci/travis"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = true
    dismissal_restrictions = [
      data.github_user.example.node_id,
      github_team.example.node_id,
      "/exampleuser",
      "exampleorganization/exampleteam",
    ]
  }

  push_restrictions = [
    data.github_user.example.node_id,
    "/exampleuser",
    "exampleorganization/exampleteam",
    # limited to a list of one type of restriction (user, team, app)
    # github_team.example.node_id
  ]

}
