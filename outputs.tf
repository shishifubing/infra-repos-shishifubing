output "repositories" {
  description = "managed repositories"
  value       = module.repositories
  # there is nothing sensitive, json is just too big
  sensitive = true
}

output "replace_repositories" {
  description = "terraform apply with mirroring to Gitlab"
  value = join(" ", [
    for name, _ in module.repositories :
    "-replace=gitlab_project.repository[\"${name}\"]"
  ])
}

output "organization" {
  description = "managed organization"
  value       = github_organization_settings.organization
  # there is nothing sensitive, json is just too big
  sensitive = true
}
