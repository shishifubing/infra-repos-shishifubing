terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.14.0"
    }
  }
}

provider "github" {
  owner = "shishifubing-com"
}
