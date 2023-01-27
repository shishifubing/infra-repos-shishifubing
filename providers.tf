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
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

locals {
  name       = "shishifubing"
  bio        = "事实浮冰"
  owner      = local.name
  owner_url  = "https://github.com/${local.owner}"
  owner_fqdn = "${local.name}.com"
  email      = "97828377+shishifubing@users.noreply.github.com"
  site       = "https://${local.owner_fqdn}"
}

provider "github" {
  owner = local.owner
}

provider "gitlab" {}
