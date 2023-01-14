output "defaults" {
  description = "built-in defaults"
  value       = local.defaults
}

output "resource" {
  description = "github_branch_protection resource"
  value       = github_branch_protection.protection
}

output "config" {
  description = "branch protection config after merging with the defaults"
  value       = local.conf
}
