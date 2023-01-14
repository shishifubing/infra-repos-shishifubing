variable "branch_protection" {
  description = "branch protection config (json)"
  type        = string
  default     = "{}"
}

variable "defaults" {
  description = "branch protection defaults (json)"
  default     = "{}"
}
