terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 5.0.0"
    }
    utils = {
      source  = "cloudposse/utils"
      version = ">= 0.3.0"
    }
  }
}
