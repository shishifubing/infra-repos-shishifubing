locals {

  repositories = yamldecode(templatefile(
    "${path.module}/repositories_github.yml", {
      owner_url = local.owner_url
    }
  ))

  // defaults

  // general settings
  archive_on_destroy = true
  visibility         = "public"
  is_template        = false

  // repository creation setttings
  // add initial commit
  auto_init = true
  // the python template has a lot of stuff
  gitignore_template = "Python"
  // GNU Affero General Public License v3.0
  license_template = "agpl-3.0"

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

  // pages
  pages_source_branch = "main"
  pages_source_path   = "/"

  // template
  template_content_include_all_branches = false
  template_content_owner                = local.owner
}

resource "github_repository" "repositories" {
  for_each = local.repositories

  name        = each.key
  description = each.value.description

  // template
  dynamic "template" {
    # if there is a template definition - create a block,
    # if there is none - do not create it
    for_each = contains(
      keys(each.value), "template"
    ) ? [each.value.template] : []
    content {
      include_all_branches = lookup(
        template.value,
        "include_all_branches",
        local.template_content_include_all_branches
      )
      owner = lookup(
        template.value,
        "owner",
        local.template_content_owner
      )
      repository = template.value.repository
    }
  }

  // general settings
  archive_on_destroy = lookup(
    each.value, "archive_on_destroy", local.archive_on_destroy
  )
  visibility = lookup(
    each.value, "visibility", local.visibility
  )
  is_template = lookup(
    each.value, "is_template", local.is_template
  )
  homepage_url = lookup(
    each.value, "homepage_url", "https://${local.domain}/${each.key}"
  )
  topics = concat(
    lookup(each.value, "topics", []), [local.owner]
  )

  // repository creation setttings
  auto_init = lookup(
    each.value, "auto_init", local.auto_init
  )
  gitignore_template = lookup(
    each.value, "gitignore_template", local.gitignore_template
  )
  license_template = lookup(
    each.value, "license_template", local.license_template
  )

  // `has` settings
  has_issues = lookup(
    each.value, "has_issues", local.has_issues
  )
  has_wiki = lookup(
    each.value, "has_wiki", local.has_wiki
  )
  has_downloads = lookup(
    each.value, "has_downloads", local.has_downloads
  )
  has_projects = lookup(
    each.value, "has_projects", local.has_projects
  )

  // PR settings
  allow_auto_merge = lookup(
    each.value, "allow_auto_merge", local.allow_auto_merge
  )
  allow_merge_commit = lookup(
    each.value, "allow_merge_commit", local.allow_merge_commit
  )
  allow_rebase_merge = lookup(
    each.value, "allow_rebase_merge", local.allow_rebase_merge
  )
  allow_squash_merge = lookup(
    each.value, "allow_squash_merge", local.allow_squash_merge
  )
  allow_update_branch = lookup(
    each.value, "allow_update_branch", local.allow_update_branch
  )
  delete_branch_on_merge = lookup(
    each.value, "delete_branch_on_merge", local.delete_branch_on_merge
  )



  /* can't use it
     - 422 Invalid request. Invalid property /source: `` is not a
       possible value. Must be one of the following: /, /docs.

       no idea, default path is "/", everything should be fine
     - 404 Not Found []

       no idea, probably because GHPages are not deployed


  // pages
  pages {
    cname = lookup(
      each.value, "pages_cname", ""
    )
    source {
      branch = lookup(
        each.value, "pages_source_branch", local.pages_source_branch
      )
      path = lookup(
        each.value, "pages_source_path", local.pages_source_path
      )
    }
  }
  */

  /* can't use it
     - Error: `422 Advanced security is always available for public repos []`

       `advanced_security` block is required if you specify
       `security_and_analysis`, so if the repository is public, you cannot
       use `security_and_analysis` at all

  // security
  security_and_analysis {
    advanced_security {
      status = lookup(
        each.value,
        "security_advanced_security",
        local.security_advanced_security
      )
    }
    secret_scanning {
      status = lookup(
        each.value, "security_secret_scanning", local.security_secret_scanning
      )
    }
    secret_scanning_push_protection {
      status = lookup(
        each.value,
        "security_secret_scanning_push_protection",
        local.security_secret_scanning_push_protection
      )
    }
  }
  */
}
