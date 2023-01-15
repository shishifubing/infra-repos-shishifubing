output "repositories" {
  description = "created repositories"
  value       = module.repositories
  # there is nothing sensitive, json is just too big
  sensitive = true
}
