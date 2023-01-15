# github repositories
module "repositories" {
  for_each = local.repositories
  source   = "./modules/repository"

  repository_name = each.key
  config          = each.value
}

# branch protection rules for github repositories
module "branch_protections" {
  for_each = local.branch_protections
  source   = "./modules/branch_protection"

  config = each.value
}

# gitlab projects mirroring github repositories
data "gitlab_group" "group" {
  full_path = local.owner
}
resource "gitlab_project" "repository" {
  for_each = module.repositories

  # gitlab repository names cannot start with a special character
  name = substr(each.value.repository.name, 0, 1) == "." ? format(
    "dot-%s",
    substr(each.value.repository.name, 1, length(each.value.repository.name))
  ) : each.value.repository.name
  description = join(" ", [
    each.value.repository.description,
    "[mirror of ${each.value.repository.html_url}]"
  ])
  import_url       = each.value.repository.http_clone_url
  namespace_id     = data.gitlab_group.group.group_id
  topics           = toset(each.value.repository.topics)
  visibility_level = each.value.repository.visibility
}

locals {
  # create a map of branch_protections with unique keys for `for_each`
  branch_protections = {
    for item in local.branch_protections_list :
    "${item.repository_id}/${item.pattern}" => item
  }
  # inject branch protection patterns and repository ids into all
  # branch_protections defined in the configs
  branch_protections_list = flatten([
    for repository_name, repository_config in local.repositories : [
      for branch_protection_pattern, branch_protection_config in
      lookup(repository_config, "branch_protections", {}) : merge(
        {
          pattern       = branch_protection_pattern,
          repository_id = repository_name
        },
        branch_protection_config
      )
    ]
  ])

  # default branch_protection config for the main branch
  branch_protections_main = {
    enforce_admins                  = true
    required_approving_review_count = 0
  }

  # dictionary of topics to reuse
  topics = {
    common       = [local.owner]
    yandex_cloud = ["cloud", "yandex-cloud"]
    terraform    = ["infrastructure", "terraform", "terraform-module"]
    nexus        = ["nexus", "sonatype-nexus", "nexus3", "sonatype-nexus3"]
    go           = ["go", "golang"]
    web          = ["javascript", "css", "html", "html5", "css3"]
    webapp       = ["app", "webapp"]
    python       = ["python", "python3"]
    vuejs        = ["vuejs", "vuejs3"]
    abandoned    = ["abandoned", "abandoned-project"]
    finished     = ["finished", "finished-project"]
    ghaction     = ["action", "actions", "github-action", "github-actions"]
    readme       = ["readme", "readme-profile"]
  }

  # main repository config
  repositories = {
    "infra-repos-${local.owner}" = {
      description = join(" ", [
        "Terraform module managing repositories in ${local.owner_url}"
      ])
      homepage_url = join("/", [
        local.owner_url, "infra-repos-${local.owner}"
      ])
      topics = concat(
        local.topics.common, local.topics.terraform,
        []
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "job-ghaction-readme-scc-code-count" = {
      description = join(" ", [
        "Github action to add and update code count in the README.md of",
        "a project"
      ])
      homepage_url = join("/", [
        local.owner_url, "job-ghaction-readme-scc-code-count"
      ])
      topics = concat(
        local.topics.common, local.topics.ghaction,
        ["scc"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    ".github" = {
      description = join(" ", [
        "Organization readme"
      ])
      homepage_url = join("/", [
        local.owner_url, ".github"
      ])
      topics = concat(
        local.topics.common, local.topics.readme,
        []
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "infra-cloud-${local.owner_fqdn}" = {
      description = join(" ", [
        "Cloud infrastructure for ${local.owner_fqdn}"
      ])
      homepage_url = join("/", [
        local.owner_url, "infra-cloud-${local.owner_fqdn}"
      ])
      topics = concat(
        local.topics.common, local.topics.terraform, local.topics.yandex_cloud,
        []
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "misc-personal-dotfiles" = {
      description = join(" ", [
        "Bash scripts, configs, ansible playbooks"
      ])
      homepage_url = join("/", [
        local.owner_url, "misc-personal-dotfiles"
      ])
      topics = concat(
        local.topics.common,
        ["dotfiles", "vim", "bash", "firefox", "ansible", "vimrc",
        "firefox-css"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "${local.owner}.github.io" = {
      description = join(" ", [
        "Personal site"
      ])
      homepage_url = join("/", [
        "https://${local.owner_fqdn}"
      ])
      topics = concat(
        local.topics.common,
        ["github-io", "github-pages"]
      )
      pages = {
        cname = local.owner_fqdn
      }
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "app-android-anki-chinese-flashcards-enricher" = {
      description = join(" ", [
        "Android app to streamline my Chinese learning workflow"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-android-anki-chinese-flashcards-enricher"
      ])
      topics = concat(
        local.topics.common,
        ["app", "android", "kotlin"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "plugin-firefox-new-tab-bookmarks" = {
      description = join(" ", [
        "Simple plugin for Firefox, boring",
        "[abandoned]"
      ])
      homepage_url = join("/", [
        local.owner_url, "plugin-firefox-new-tab-bookmarks"
      ])
      topics = concat(
        local.topics.common, local.topics.web, local.topics.abandoned,
        ["javascript", "firefox", "firefox-addon"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "app-desktop-useless-cpp-gui" = {
      description = join(" ", [
        "Desktop GUI written using C++ and Qt, it does absolutely nothing",
        "[abandoned]"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-desktop-useless-cpp-gui"
      ])
      topics = concat(
        local.topics.common, local.topics.abandoned,
        ["desktop-app", "gui", "qt", "cpp", "qt5"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "snippets-javascript-assignments" = {
      description = join(" ", [
        "Javascript assignments, boring",
        "[finished]"
      ])
      homepage_url = join("/", [
        local.owner_url, "snippets-javascript-assignments"
      ])
      topics = concat(
        local.topics.web, local.topics.common,
        []
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "app-web-crawler-book-creator" = {
      description = join(" ", [
        "Web scraper I was building in java a long time ago and ",
        "started remaking using Django",
        "[abandoned]"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-web-crawler-book-creator"
      ])
      topics = concat(
        local.topics.common, local.topics.python, local.topics.abandoned,
        local.topics.web, local.topics.webapp,
        ["django", "web-scraping"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "app-web-tianyi" = {
      description = join(" ", [
        "SPA CI/CD app",
        "[abandoned]"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-web-tianyi"
      ])
      topics = concat(
        local.topics.go, local.topics.web, local.topics.webapp,
        local.topics.vuejs, local.topics.abandoned, local.topics.common,
        ["redis", "spa", "postgresql", "scss", "vuex-store"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "app-cli-autoscroll" = {
      description = join(" ", [
        "Cross-platform CLI app enabling autoscroll",
        "[finished]"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-cli-autoscroll"
      ])
      topics = concat(
        local.topics.python, local.topics.common, local.topics.finished,
        ["pyqt5", "cli-app"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "app-web-django-assignment" = {
      description = join(" ", [
        "SSR web app",
        "[finished]"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-web-django-assignment"
      ])
      topics = concat(
        local.topics.web, local.topics.webapp, local.topics.common,
        local.topics.finished,
        ["python", "bootstrap", "django", "ssr", "python3"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "snippets-golang-leetcode" = {
      description = join(" ", [
        "Some leetcode tasks"
      ])
      homepage_url = join("/", [
        local.owner_url, "snippets-golang-leetcode"
      ])
      topics = concat(
        local.topics.go, local.topics.common,
        ["leetcode", "leetcode-solutions"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }

    "plugin-sonatype-nexus-security-check" = {
      description = join(" ", [
        "Security plugin for Sonatype Nexus 3",
        "[finished]"
      ])
      homepage_url = join("/", [
        local.owner_url, "plugin-sonatype-nexus-security-check"
      ])
      topics = concat(
        local.topics.nexus, local.topics.common, local.topics.finished,
        ["plugin", "java", "maven", "apache-karaf", "sonatype-nexus-plugin"]
      )
      branch_protections = {
        "main" = local.branch_protections_main
      }
    }
  }
}
