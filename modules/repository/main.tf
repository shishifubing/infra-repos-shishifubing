resource "github_repository" "repository" {
  name        = var.repository_name
  description = var.config.description

  lifecycle {
    prevent_destroy = true
  }

  // general settings
  archive_on_destroy                      = var.config.archive_on_destroy
  archived                                = var.config.archived
  visibility                              = var.config.visibility
  is_template                             = var.config.is_template
  homepage_url                            = var.config.homepage_url
  topics                                  = var.config.topics
  ignore_vulnerability_alerts_during_read = var.config.ignore_vulnerability_alerts_during_read
  vulnerability_alerts                    = var.config.vulnerability_alerts

  // repository creation setttings
  auto_init          = var.config.auto_init
  gitignore_template = var.config.gitignore_template
  license_template   = var.config.license_template

  // `has` settings
  has_issues    = var.config.has_issues
  has_wiki      = var.config.has_wiki
  has_downloads = var.config.has_downloads
  has_projects  = var.config.has_projects

  // PR settings
  allow_auto_merge            = var.config.allow_auto_merge
  allow_merge_commit          = var.config.allow_merge_commit
  allow_rebase_merge          = var.config.allow_rebase_merge
  allow_squash_merge          = var.config.allow_squash_merge
  allow_update_branch         = var.config.allow_update_branch
  delete_branch_on_merge      = var.config.delete_branch_on_merge
  merge_commit_message        = var.config.merge_commit_message
  merge_commit_title          = var.config.merge_commit_title
  squash_merge_commit_message = var.config.squash_merge_commit_message
  squash_merge_commit_title   = var.config.squash_merge_commit_title

  dynamic "template" {
    // if repository config has a template definition, create the block
    for_each = var.config.template == null ? {} : { _ = var.config.template }
    content {
      include_all_branches = template.value.content.include_all_branches
      owner                = template.value.content.owner
      repository           = template.value.content.repository
    }
  }

  dynamic "pages" {
    // if repository config has a definition of pages, create a block
    for_each = var.config.pages == null ? {} : { _ = var.config.pages }
    content {
      cname = pages.value.cname
      source {
        branch = pages.value.source.branch
        path   = pages.value.source.path
      }
    }
  }

  dynamic "security_and_analysis" {
    for_each = var.config.security_and_analysis == null ? {} : { _ = var.config.security_and_analysis }
    content {
      advanced_security {
        status = var.config.security_and_analysis.advanced_security.status
      }
      secret_scanning {
        status = var.config.security_and_analysis.secret_scanning.status
      }
      secret_scanning_push_protection {
        status = var.config.security_and_analysis.secret_scanning_push_protection.status
      }
    }
  }
}
