output "defaults" {
  description = "built-in defaults"
  value       = local.defaults
}

output "repository" {
  description = "github_repository resource"
  value       = github_repository.repository
}

output "config" {
  description = "repository config after merging with the defaults"
  value       = local.conf
}
