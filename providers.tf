terraform {
  backend "s3" {}

  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.14.0"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "15.7.1"
    }
  }
}

locals {
  owner      = "shishifubing-com"
  owner_url  = "https://github.com/${local.owner}"
  owner_fqdn = "shishifubing.com"
}

provider "github" {
  owner = local.owner
}

provider "gitlab" {}
