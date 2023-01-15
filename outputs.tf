output "repositories" {
  description = "managed repositories"
  value       = module.repositories
  # there is nothing sensitive, json is just too big
  sensitive = true
}

output "organization" {
  description = "managed organization"
  value       = github_organization_settings.organization
  # there is nothing sensitive, json is just too big
  sensitive = true
}
