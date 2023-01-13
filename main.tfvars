owner = "shishifubing-com"

repositories_template_path = "./repositories_github.yml"

repositories_variables = {
  owner_url = "https://github.com/shishifubing-com"
}

repositories_defaults = {
  // general settings
  archive_on_destroy = true
  visibility         = "public"
  is_template        = false
  homepage_url       = "https://github.com/shishifubing-com"

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
  template_content_owner                = "octocat"
}
