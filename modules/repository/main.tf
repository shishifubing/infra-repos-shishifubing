data "utils_deep_merge_json" "conf" {
  input = [
    jsonencode(local.defaults),
    var.repository,
  ]
}

locals {
  conf = jsondecode(data.utils_deep_merge_json.conf.output)
}

resource "github_repository" "repository" {
  name        = var.repository_name
  description = local.conf.description

  lifecycle {
    prevent_destroy = true
  }

  // general settings
  archive_on_destroy                      = local.conf.archive_on_destroy
  archived                                = local.conf.archived
  visibility                              = local.conf.visibility
  is_template                             = local.conf.is_template
  homepage_url                            = local.conf.homepage_url
  topics                                  = local.conf.topics
  ignore_vulnerability_alerts_during_read = local.conf.ignore_vulnerability_alerts_during_read
  vulnerability_alerts                    = local.conf.vulnerability_alerts

  // repository creation setttings
  auto_init          = local.conf.auto_init
  gitignore_template = local.conf.gitignore_template
  license_template   = local.conf.license_template

  // `has` settings
  has_issues    = local.conf.has_issues
  has_wiki      = local.conf.has_wiki
  has_downloads = local.conf.has_downloads
  has_projects  = local.conf.has_projects

  // PR settings
  allow_auto_merge            = local.conf.allow_auto_merge
  allow_merge_commit          = local.conf.allow_merge_commit
  allow_rebase_merge          = local.conf.allow_rebase_merge
  allow_squash_merge          = local.conf.allow_squash_merge
  allow_update_branch         = local.conf.allow_update_branch
  delete_branch_on_merge      = local.conf.delete_branch_on_merge
  merge_commit_message        = local.conf.merge_commit_message
  merge_commit_title          = local.conf.merge_commit_title
  squash_merge_commit_message = local.conf.squash_merge_commit_message
  squash_merge_commit_title   = local.conf.squash_merge_commit_title

  dynamic "template" {
    // if repository config has a template definition, create the block
    for_each = local.conf.template.enabled ? { _ = local.conf.template } : {}
    content {
      include_all_branches = template.value.content.include_all_branches
      owner                = template.value.content.owner
      repository           = template.value.content.repository
    }
  }

  dynamic "pages" {
    // if repository config has a definition of pages, create a block
    for_each = local.conf.pages.enabled ? { _ = local.conf.pages } : {}
    content {
      cname = pages.value.cname
      source {
        branch = pages.value.source.branch
        path   = pages.value.source.path
      }
    }
  }

  security_and_analysis {
    advanced_security {
      status = local.conf.security.advanced_security.status
    }
    secret_scanning {
      status = local.conf.security.secret_scanning.status
    }
    secret_scanning_push_protection {
      status = local.conf.security.secret_scanning_push_protection.status
    }
  }
}
