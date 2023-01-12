locals {
  // general settings
  archive_on_destroy = true
  visibility         = "public"

  // `has` settings
  has_issues    = true
  has_wiki      = true
  has_downloads = true
  has_projects  = false


  // PR settings
  allow_auto_merge       = false
  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  allow_update_branch    = false
  delete_branch_on_merge = true

  // security
  security_advanced_security               = "enabled"
  security_secret_scanning                 = "enabled"
  security_secret_scanning_push_protection = "enabled"


  // repository creation setttings
  // add initial commit
  auto_init = true
  // the python template has a lot of stuff
  gitignore_template = "Python"
  // GNU Affero General Public License v3.0
  license_template = "agpl-3.0"
}

resource "github_repository" "infra-repos-shishifubing-com" {
  name = "infra-repos-shishifubing-com"
  description = join(" ", [
    "Terraform module managing repositories in",
    "https://github.com/shishifubing-com"
  ])

  security_and_analysis {
    advanced_security {
      status = local.security_advanced_security
    }
    secret_scanning {
      status = local.security_secret_scanning
    }
    secret_scanning_push_protection {
      status = local.security_secret_scanning_push_protection
    }
  }

  // custom settings
  homepage_url = "${local.owner_url}/infra-repos-shishifubing-com"

  // default settings
  visibility             = local.visibility
  allow_auto_merge       = local.allow_auto_merge
  allow_merge_commit     = local.allow_merge_commit
  allow_rebase_merge     = local.allow_rebase_merge
  allow_squash_merge     = local.allow_squash_merge
  allow_update_branch    = local.allow_update_branch
  archive_on_destroy     = local.archive_on_destroy
  auto_init              = local.auto_init
  delete_branch_on_merge = local.delete_branch_on_merge
  gitignore_template     = local.gitignore_template
  license_template       = local.license_template
  has_issues             = local.has_issues
  has_wiki               = local.has_wiki
  has_downloads          = local.has_downloads
  has_projects           = local.has_projects
}



# job-ghaction-readme-scc-code-count
# .github
# infra-cloud-shishifubing.com
# misc-personal-dotfiles
# shishifubing-com.github.io
# app-android-anki-chinese-flashcards-enricher
# plugin-firefox-new-tab-bookmarks
# app-desktop-useless-cpp-gui
# snippets-javascript-assignments
# app-web-crawler-book-creator
# app-web-tianyi
# app-cli-autoscroll
# app-web-django-assignment
# snippets-golang-leetcode
# plugin-sonatype-nexus-security-check
