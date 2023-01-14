output "defaults" {
  value = local.defaults
}

output "repository" {
  value = github_repository.repository
}

output "config" {
  value = local.conf
}
