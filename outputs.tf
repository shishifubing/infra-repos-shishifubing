output "repositories" {
  description = "list of github repositories"
  value       = join(" ", keys(module.repositories))
  # it's not sensitive, I just don't want to clutter logs
  sensitive = true
}
