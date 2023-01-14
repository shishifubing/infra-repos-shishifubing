variable "repository_name" {
  description = "repository name"
  type        = string
}

variable "repository" {
  description = "repository config (json)"
  default     = "{}"
}

variable "defaults" {
  description = "repository defaults (json)"
  default     = "{}"
}
