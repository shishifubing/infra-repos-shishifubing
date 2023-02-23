# github repositories
module "repositories" {
  for_each = local.repositories
  source   = "./modules/repository"

  repository_name = each.key
  config          = each.value
}

module "branch_protections_main" {
  for_each = module.repositories
  source   = "./modules/branch_protection"

  config = {
    repository_id                   = each.value.repository.node_id
    pattern                         = "main"
    enforce_admins                  = true
    required_approving_review_count = 0
    required_status_checks = {
      "commits" = {
        # https://github.com/marketplace/commitcheck
        # https://www.commitcheck.com
        contexts = ["CommitCheck"]
        strict   = true
      }
    }
  }
}

module "branch_protections_wildcard" {
  for_each   = module.repositories
  source     = "./modules/branch_protection"
  depends_on = [module.branch_protections_main]

  config = {
    repository_id           = each.value.repository.node_id
    pattern                 = "*"
    required_linear_history = true
    allows_deletions        = true
    allows_force_pushes     = true
    required_status_checks = {
      "commits" = {
        # https://github.com/marketplace/commitcheck
        # https://www.commitcheck.com
        contexts = ["CommitCheck"]
        strict   = true
      }
    }
  }
}

resource "github_repository_tag_protection" "protections" {
  for_each   = module.repositories
  repository = each.value.repository.name
  pattern    = "v*"
}

resource "github_branch_default" "default" {
  for_each = module.repositories

  repository = each.key
  branch     = "main"
}

resource "github_actions_organization_permissions" "main" {
  allowed_actions      = "all"
  enabled_repositories = "all"
}

#
# gitlab stuff
#
data "gitlab_group" "group" {
  full_path = local.owner
}


resource "time_rotating" "day" {
  rotation_days = 1
}

# I have to use time_static because of https://github.com/hashicorp/terraform-provider-time/issues/118
resource "time_static" "day" {
  rfc3339 = time_rotating.day.rfc3339
}

resource "gitlab_project" "repositories" {
  for_each = module.repositories

  lifecycle {
    # ignore all changes to not clutter logs
    ignore_changes = all
    # replace every day
    replace_triggered_by = [time_static.day]
  }

  # gitlab repository names cannot start with a special character
  name = substr(each.value.repository.name, 0, 1) == "." ? format(
    "dot-%s",
    substr(each.value.repository.name, 1, length(each.value.repository.name))
  ) : each.value.repository.name
  description = join(" ", [
    each.value.repository.description,
    "[mirror of ${each.value.repository.html_url}]",
    "[${time_static.day.rfc3339}]"
  ])
  import_url       = each.value.repository.http_clone_url
  namespace_id     = data.gitlab_group.group.group_id
  topics           = toset(each.value.repository.topics)
  visibility_level = each.value.repository.visibility
}
