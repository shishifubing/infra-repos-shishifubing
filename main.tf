# github repositories
module "repositories" {
  for_each = local.repositories
  source   = "./modules/repository"

  repository_name = each.key
  config          = each.value
}

# branch protection rules for github repositories
module "branch_protections" {
  for_each = local.branch_protections
  source   = "./modules/branch_protection"

  config = each.value
}

resource "github_branch_default" "default" {
  for_each = module.repositories

  repository = each.key
  branch     = "main"
}

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
    "[mirror of ${each.value.repository.html_url}]"
  ])
  import_url       = each.value.repository.http_clone_url
  namespace_id     = data.gitlab_group.group.group_id
  topics           = toset(each.value.repository.topics)
  visibility_level = each.value.repository.visibility
}
