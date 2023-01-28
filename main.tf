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
    # reimport each repository once a day
    replace_triggered_by = [
      time_rotating.day
    ]
    # if you set `all`, replace_triggered_by will not work
    ignore_changes = [
      allow_merge_on_skipped_pipeline, analytics_access_level, approvals_before_merge, archived, auto_cancel_pending_pipelines, auto_devops_deploy_strategy, auto_devops_enabled, autoclose_referenced_issues, avatar_hash, avatar_url, build_git_strategy, build_timeout, builds_access_level, ci_default_git_depth, ci_forward_deployment_enabled, ci_separated_caches, container_registry_access_level, container_registry_enabled, default_branch, emails_disabled, forked_from_project_id, forking_access_level, http_url_to_repo, id, import_url, issues_access_level, issues_enabled, lfs_enabled, merge_method, merge_pipelines_enabled, merge_requests_access_level, merge_requests_enabled, merge_trains_enabled, mirror, mirror_overwrites_diverged_branches, mirror_trigger_builds, name, only_allow_merge_if_all_discussions_are_resolved, only_allow_merge_if_pipeline_succeeds, only_mirror_protected_branches, operations_access_level, packages_enabled, pages_access_level, path, path_with_namespace, pipelines_enabled, printing_merge_request_link_enabled, public_builds, remove_source_branch_after_merge, repository_access_level, repository_storage, request_access_enabled, requirements_access_level, resolve_outdated_diff_discussions, restrict_user_defined_variables, runners_token, security_and_compliance_access_level, shared_runners_enabled, snippets_access_level, snippets_enabled, squash_option, ssh_url_to_repo, tags, topics, web_url, wiki_access_level, wiki_enabled, container_expiration_policy, push_rules
    ]
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
