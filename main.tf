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

# gitlab projects mirroring github repositories
data "gitlab_group" "group" {
  full_path = local.owner
}

resource "gitlab_project" "repository" {
  for_each = module.repositories

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
