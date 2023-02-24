resource "github_membership" "bot" {
  username = "shishifubing-bot"
  role     = "member"
}

resource "github_team" "admins" {
  name                      = "admins"
  description               = "Grants admin rights to all shishifubing repositories"
  privacy                   = "closed"
  create_default_maintainer = true
}

resource "github_team_membership" "bot" {
  team_id  = github_team.admins.id
  username = github_membership.bot.username
  role     = "maintainer"
}

resource "github_team_repository" "admins" {
  for_each = module.repositories

  team_id    = github_team.admins.id
  repository = each.value.repository.name
  permission = "admin"
}

resource "github_organization_settings" "organization" {
  billing_email                                                = local.email
  email                                                        = local.email
  company                                                      = local.name
  blog                                                         = local.site
  description                                                  = local.bio
  has_organization_projects                                    = true
  has_repository_projects                                      = true
  default_repository_permission                                = "read"
  members_can_create_repositories                              = true
  members_can_create_public_repositories                       = true
  members_can_create_private_repositories                      = true
  members_can_create_pages                                     = true
  members_can_create_public_pages                              = true
  members_can_create_private_pages                             = false
  members_can_fork_private_repositories                        = false
  web_commit_signoff_required                                  = true
  advanced_security_enabled_for_new_repositories               = true
  dependabot_alerts_enabled_for_new_repositories               = true
  dependabot_security_updates_enabled_for_new_repositories     = true
  dependency_graph_enabled_for_new_repositories                = true
  secret_scanning_enabled_for_new_repositories                 = true
  secret_scanning_push_protection_enabled_for_new_repositories = true
}
