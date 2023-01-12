terraform {
  backend "s3" {

  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.14.0"
    }
  }
}

locals {
  owner     = "shishifubing-com"
  owner_url = "https://github.com/${local.owner}"
}

provider "github" {
  owner = local.owner
}
