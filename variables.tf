variable "owner" {
  description = "owner of github resources"
}

variable "repositories_template_path" {
  description = "path to the template, either relative or absolute"
}

variable "repositories_variables" {
  description = "map of values to be passed to the repository template"
  type        = map(any)
}

variable "repositories_defaults" {
  description = "defaults for repository resources"
  type        = map(any)
}
