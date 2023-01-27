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

# forces replacement once a day
resource "time_rotating" "day" {
  rotation_days = 1
}

resource "gitlab_project" "repositories" {
  for_each = module.repositories

  lifecycle {
    # reimport the repository once a day
    # it is more convenient than running some bash script every time
    replace_triggered_by = [
      time_rotating.day
    ]
    # modifying gitlab repositories is pointless since they are going to be replaced anyway
    ignore_changes = all
  }

  # gitlab repository names cannot start with a special character
  name = substr(each.value.repository.name, 0, 1) == "." ? format(
    "dot-%s",
    substr(each.value.repository.name, 1, length(each.value.repository.name))
  ) : each.value.repository.name
  description = join(" ", [
    each.value.repository.description,
    "[mirror of ${each.value.repository.html_url}]",
    "[${time_rotating.day.id}]"
  ])
  import_url       = each.value.repository.http_clone_url
  namespace_id     = data.gitlab_group.group.group_id
  topics           = toset(each.value.repository.topics)
  visibility_level = each.value.repository.visibility
}
