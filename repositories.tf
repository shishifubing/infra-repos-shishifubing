locals {

  repositories = yamldecode(templatefile(
    var.repositories_template_path, var.repositories_variables
  ))

}

resource "github_repository" "repositories" {
  for_each = local.repositories

  name        = each.key
  description = lookup(each.value, "description", "")

  dynamic "template" {
    # if there is a template definition - create the block,
    # if there is none - do not create it
    for_each = contains(
      keys(each.value), "template"
    ) ? [each.value.template] : []
    content {
      include_all_branches = lookup(
        template.value,
        "include_all_branches",
        var.repositories_defaults.template_content_include_all_branches
      )
      owner = lookup(
        template.value,
        "owner",
        var.repositories_defaults.template_content_owner
      )
      repository = template.value.repository
    }
  }

  // general settings
  archive_on_destroy = lookup(
    each.value,
    "archive_on_destroy",
    var.repositories_defaults.archive_on_destroy
  )
  visibility = lookup(
    each.value,
    "visibility",
    var.repositories_defaults.visibility
  )
  is_template = lookup(
    each.value,
    "is_template",
    var.repositories_defaults.is_template
  )
  homepage_url = lookup(
    each.value,
    "homepage_url",
    "${var.repositories_defaults.homepage_url}/${each.key}"
  )
  topics = concat(
    lookup(each.value, "topics", []), [var.owner]
  )

  // repository creation setttings
  auto_init = lookup(
    each.value,
    "auto_init",
    var.repositories_defaults.auto_init
  )
  gitignore_template = lookup(
    each.value,
    "gitignore_template",
    var.repositories_defaults.gitignore_template
  )
  license_template = lookup(
    each.value,
    "license_template",
    var.repositories_defaults.license_template
  )

  // `has` settings
  has_issues = lookup(
    each.value,
    "has_issues",
    var.repositories_defaults.has_issues
  )
  has_wiki = lookup(
    each.value,
    "has_wiki",
    var.repositories_defaults.has_wiki
  )
  has_downloads = lookup(
    each.value,
    "has_downloads",
    var.repositories_defaults.has_downloads
  )
  has_projects = lookup(
    each.value,
    "has_projects",
    var.repositories_defaults.has_projects
  )

  // PR settings
  allow_auto_merge = lookup(
    each.value,
    "allow_auto_merge",
    var.repositories_defaults.allow_auto_merge
  )
  allow_merge_commit = lookup(
    each.value,
    "allow_merge_commit",
    var.repositories_defaults.allow_merge_commit
  )
  allow_rebase_merge = lookup(
    each.value,
    "allow_rebase_merge",
    var.repositories_defaults.allow_rebase_merge
  )
  allow_squash_merge = lookup(
    each.value,
    "allow_squash_merge",
    var.repositories_defaults.allow_squash_merge
  )
  allow_update_branch = lookup(
    each.value,
    "allow_update_branch",
    var.repositories_defaults.allow_update_branch
  )
  delete_branch_on_merge = lookup(
    each.value,
    "delete_branch_on_merge",
    var.repositories_defaults.delete_branch_on_merge
  )

  // template
  dynamic "pages" {
    # if there is a template definition - create the block,
    # if there is none - do not create it
    for_each = contains(
      keys(each.value), "pages"
    ) ? [each.value.pages] : []
    content {
      cname = pages.value.cname
      source {
        branch = lookup(
          pages.value,
          "branch",
          var.repositories_defaults.pages_source_branch
        )
        path = lookup(
          pages.value,
          "path",
          var.repositories_defaults.pages_source_path
        )
      }
    }
  }

  security_and_analysis {
    advanced_security {
      status = lookup(
        each.value,
        "security_advanced_security",
        var.repositories_defaults.security_advanced_security
      )
    }
    secret_scanning {
      status = lookup(
        each.value,
        "security_secret_scanning",
        var.repositories_defaults.security_secret_scanning
      )
    }
    secret_scanning_push_protection {
      status = lookup(
        each.value,
        "security_secret_scanning_push_protection",
        var.repositories_defaults.security_secret_scanning_push_protection
      )
    }
  }
}
