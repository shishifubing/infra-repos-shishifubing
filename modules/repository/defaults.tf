locals {
  defaults = {
    // general settings
    description                             = ""
    archive_on_destroy                      = true
    archived                                = false
    visibility                              = "public"
    is_template                             = false
    ignore_vulnerability_alerts_during_read = false
    vulnerability_alerts                    = true
    homepage_url                            = ""

    // repository creation setttings
    // add initial commit
    auto_init = true
    // the python template has a lot of stuff
    gitignore_template = "Python"
    // GNU Affero General Public License v3.0
    license_template = "agpl-3.0"

    // `has` settings
    has_issues    = true
    has_wiki      = false
    has_downloads = false
    has_projects  = false

    // PR settings
    allow_auto_merge            = false
    allow_merge_commit          = false
    allow_rebase_merge          = false
    allow_squash_merge          = true
    allow_update_branch         = true
    delete_branch_on_merge      = true
    merge_commit_message        = "PR_TITLE"
    merge_commit_title          = "MERGE_MESSAGE"
    squash_merge_commit_message = "COMMIT_MESSAGES"
    squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"

    // security_and_analysis
    security = {
      advanced_security = {
        status = "enabled"
      }
      secret_scanning = {
        status = "enabled"
      }
      secret_scanning_push_protection = {
        status = "enabled"
      }
    }

    // pages
    pages = {
      enabled = false
      cname   = ""
      source = {
        branch = "main"
        path   = "/"
      }
    }

    // template
    template = {
      enabled              = false
      include_all_branches = false
      owner                = ""
    }
  }
}
