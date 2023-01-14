module "repositories" {
  for_each = local.repositories
  source   = "./modules/repository"

  repository_name = each.key
  repository      = jsonencode(each.value)
}

module "branch_protections" {
  for_each   = local.branch_protections
  depends_on = [module.repositories]
  source     = "./modules/branch_protection"

  branch_protection = jsonencode(each.value)
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
      for branch_protection_pattern, branch_protection_config in lookup(
        repository_config, "branch_protections", {}
        ) : [
        merge(
          {
            pattern       = branch_protection_pattern,
            repository_id = repository_name
          },
          branch_protection_config
        )
      ]
    ]
  ])

  repositories = {
    "infra-repos-${local.owner}" = {
      description = join(" ", [
        "Terraform module managing repositories in ${local.owner_url}"
      ])
      homepage_url = join("/", [
        local.owner_url, "infra-repos-${local.owner}"
      ])
      topics = [
        "infrastructure", "terraform", "terraform-github", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "job-ghaction-readme-scc-code-count" = {
      description = join(" ", [
        "Github action to add and update code count in the README.md of ",
        "a project"
      ])
      homepage_url = join("/", [
        local.owner_url, "job-ghaction-readme-scc-code-count"
      ])
      topics = [
        "github-action", "scc", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    ".github" = {
      description = join(" ", [
        "Organization readme"
      ])
      homepage_url = join("/", [
        local.owner_url, ".github"
      ])
      topics = [
        "readme", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "infra-cloud-${local.owner_fqdn}" = {
      description = join(" ", [
        "Cloud infrastructure for shishifubing.com"
      ])
      homepage_url = join("/", [
        local.owner_url, "infra-cloud-${local.owner_fqdn}"
      ])
      topics = [
        "terraform", "cloud", "yandex-cloud", "infrastructure",
        local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "misc-personal-dotfiles" = {
      description = join(" ", [
        "Bash scripts, configs, ansible playbooks"
      ])
      homepage_url = join("/", [
        local.owner_url, "misc-personal-dotfiles"
      ])
      topics = [
        "vim", "bash", "firefox", "ansible", "vimrc", "firefox-css",
        local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "${local.owner}.github.io" = {
      description = join(" ", [
        "Personal site"
      ])
      homepage_url = join("/", [
        "https://${local.owner_fqdn}"
      ])
      topics = [
        "github-io", "github-pages", local.owner
      ]
      pages = {
        enabled = true
        cname   = local.owner_fqdn
      }
      branch_protections = {
        main = {}
      }
    }

    "app-android-anki-chinese-flashcards-enricher" = {
      description = join(" ", [
        "Android app to streamline my Chinese learning workflow"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-android-anki-chinese-flashcards-enricher"
      ])
      topics = [
        "app", "android", "kotlin", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "plugin-firefox-new-tab-bookmarks" = {
      description = join(" ", [
        "Simple plugin for Firefox"
      ])
      homepage_url = join("/", [
        local.owner_url, "plugin-firefox-new-tab-bookmarks"
      ])
      topics = [
        "javascript", "firefox", "firefox-addon", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "app-desktop-useless-cpp-gui" = {
      description = join(" ", [
        "Desktop GUI written using C++ and Qt, it does absolutely nothing"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-desktop-useless-cpp-gui"
      ])
      topics = [
        "desktop-app", "gui", "qt", "cpp", "abandoned", "qt5", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "snippets-javascript-assignments" = {
      description = join(" ", [
        "Javascript assignments"
      ])
      homepage_url = join("/", [
        local.owner_url, "snippets-javascript-assignments"
      ])
      topics = [
        "css", "html", "html5", "css3", "javascript", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "app-web-crawler-book-creator" = {
      description = join(" ", [
        "Web scraper I was building in java a long time ago and ",
        "started remaking using Django"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-web-crawler-book-creator"
      ])
      topics = [
        "python", "django", "python3", "web-scraping", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "app-web-tianyi" = {
      description = join(" ", [
        "SPA CI/CD app"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-web-tianyi"
      ])
      topics = [
        "javascript", "go", "html", "redis", "golang", "vuejs", "spa", "html5",
        "postgresql", "scss", "abandoned", "webapp", "vuex-store", "vuejs3",
        local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "app-cli-autoscroll" = {
      description = join(" ", [
        "Cross-platform CLI app enabling autoscroll"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-cli-autoscroll"
      ])
      topics = [
        "python", "pyqt5", "python3", "cli-app", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "app-web-django-assignment" = {
      description = join(" ", [
        "SSR web app"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-web-django-assignment"
      ])
      topics = [
        "javascript", "css", "python", "html", "bootstrap", "django", "html5",
        "ssr", "css3", "python3", "webapp", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "snippets-golang-leetcode" = {
      description = join(" ", [
        "Some leetcode tasks"
      ])
      homepage_url = join("/", [
        local.owner_url, "snippets-golang-leetcode"
      ])
      topics = [
        "go", "golang", "leetcode", "leetcode-solutions", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }

    "plugin-sonatype-nexus-security-check" = {
      description = join(" ", [
        "Security plugin for Sonatype Nexus 3"
      ])
      homepage_url = join("/", [
        local.owner_url, "plugin-sonatype-nexus-security-check"
      ])
      topics = [
        "plugin", "java", "maven", "nexus", "sonatype-nexus", "nexus3",
        "apache-karaf", "sonatype-nexus-plugin", "sonatype-nexus3", local.owner
      ]
      branch_protections = {
        main = {}
      }
    }
  }
}
