output "repositories" {
  description = "map of github repositories"
  value       = module.repositories
  # it's not sensitive, I just don't want to clutter logs
  sensitive = true
}
