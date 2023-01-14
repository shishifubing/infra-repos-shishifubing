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
  repositories = {
    "infra-repos-${local.owner}" = {
      description = join(" ", [
        "Terraform module managing repositories in ${local.owner_url}"
      ])
      homepage_url = join("/", [
        local.owner_url, "infra-repos-${local.owner}"
      ])
      topics = concat(local.topics.common, local.topics.terraform, [

      ])
      branch_protections = local.branch_protections_main
    }

    "job-ghaction-readme-scc-code-count" = {
      description = join(" ", [
        "Github action to add and update code count in the README.md of ",
        "a project"
      ])
      homepage_url = join("/", [
        local.owner_url, "job-ghaction-readme-scc-code-count"
      ])
      topics = concat(local.topics.common, [
        "github-action", "scc"
      ])
      branch_protections = local.branch_protections_main
    }

    ".github" = {
      description = join(" ", [
        "Organization readme"
      ])
      homepage_url = join("/", [
        local.owner_url, ".github"
      ])
      topics = concat(local.topics.common, [
        "readme"
      ])
      branch_protections = local.branch_protections_main
    }

    "infra-cloud-${local.owner_fqdn}" = {
      description = join(" ", [
        "Cloud infrastructure for shishifubing.com"
      ])
      homepage_url = join("/", [
        local.owner_url, "infra-cloud-${local.owner_fqdn}"
      ])
      topics = concat(
        local.topics.common, local.topics.terraform, local.topics.yandex_cloud,
        []
      )
      branch_protections = local.branch_protections_main
    }

    "misc-personal-dotfiles" = {
      description = join(" ", [
        "Bash scripts, configs, ansible playbooks"
      ])
      homepage_url = join("/", [
        local.owner_url, "misc-personal-dotfiles"
      ])
      topics = concat(local.topics.common, [
        "vim", "bash", "firefox", "ansible", "vimrc", "firefox-css"
      ])
      branch_protections = local.branch_protections_main
    }

    "${local.owner}.github.io" = {
      description = join(" ", [
        "Personal site"
      ])
      homepage_url = join("/", [
        "https://${local.owner_fqdn}"
      ])
      topics = concat(local.topics.common, [
        "github-io", "github-pages"
      ])
      pages = {
        enabled = true
        cname   = local.owner_fqdn
      }
      branch_protections = local.branch_protections_main
    }

    "app-android-anki-chinese-flashcards-enricher" = {
      description = join(" ", [
        "Android app to streamline my Chinese learning workflow"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-android-anki-chinese-flashcards-enricher"
      ])
      topics = concat(local.topics.common, [
        "app", "android", "kotlin"
      ])
      branch_protections = local.branch_protections_main
    }

    "plugin-firefox-new-tab-bookmarks" = {
      description = join(" ", [
        "Simple plugin for Firefox"
      ])
      homepage_url = join("/", [
        local.owner_url, "plugin-firefox-new-tab-bookmarks"
      ])
      topics = concat(local.topics.common, [
        "javascript", "firefox", "firefox-addon"
      ])
      branch_protections = local.branch_protections_main
    }

    "app-desktop-useless-cpp-gui" = {
      description = join(" ", [
        "Desktop GUI written using C++ and Qt, it does absolutely nothing"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-desktop-useless-cpp-gui"
      ])
      topics = concat(local.topics.common, local.topics.abandoned, [
        "desktop-app", "gui", "qt", "cpp", "qt5"
      ])
      branch_protections = local.branch_protections_main
    }

    "snippets-javascript-assignments" = {
      description = join(" ", [
        "Javascript assignments"
      ])
      homepage_url = join("/", [
        local.owner_url, "snippets-javascript-assignments"
      ])
      topics             = concat(local.topics.web, local.topics.common)
      branch_protections = local.branch_protections_main
    }

    "app-web-crawler-book-creator" = {
      description = join(" ", [
        "Web scraper I was building in java a long time ago and ",
        "started remaking using Django"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-web-crawler-book-creator"
      ])
      topics = concat(
        local.topics.common, local.topics.python, local.topics.abandoned,
        local.topics.web, ["django", "web-scraping"]
      )
      branch_protections = local.branch_protections_main
    }

    "app-web-tianyi" = {
      description = join(" ", [
        "SPA CI/CD app"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-web-tianyi"
      ])
      topics = concat(
        local.topics.go, local.topics.web, local.topics.vuejs,
        local.topics.abandoned, local.topics.common,
        ["redis", "spa", "postgresql", "scss", "vuex-store"]
      )
      branch_protections = local.branch_protections_main
    }

    "app-cli-autoscroll" = {
      description = join(" ", [
        "Cross-platform CLI app enabling autoscroll"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-cli-autoscroll"
      ])
      topics = concat(local.topics.python, local.topics.common, [
        "pyqt5", "cli-app"
      ])
      branch_protections = local.branch_protections_main
    }

    "app-web-django-assignment" = {
      description = join(" ", [
        "SSR web app"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-web-django-assignment"
      ])
      topics = concat(local.topics.web, local.topics.common, [
        "python", "bootstrap", "django", "ssr", "python3"
      ])
      branch_protections = local.branch_protections_main
    }

    "snippets-golang-leetcode" = {
      description = join(" ", [
        "Some leetcode tasks"
      ])
      homepage_url = join("/", [
        local.owner_url, "snippets-golang-leetcode"
      ])
      topics = concat(local.topics.go, local.topics.common, [
        "leetcode", "leetcode-solutions"
      ])
      branch_protections = local.branch_protections_main
    }

    "plugin-sonatype-nexus-security-check" = {
      description = join(" ", [
        "Security plugin for Sonatype Nexus 3"
      ])
      homepage_url = join("/", [
        local.owner_url, "plugin-sonatype-nexus-security-check"
      ])
      topics = concat(local.topics.nexus, local.topics.common, [
        "plugin", "java", "maven", "apache-karaf", "sonatype-nexus-plugin"
      ])
      branch_protections = local.branch_protections_main
    }
  }

  branch_protections_main = {
    main = {
      enforce_admins = true
    }
  }

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


  topics = {
    common       = [local.owner]
    yandex_cloud = ["cloud", "yandex-cloud"]
    terraform    = ["infrastructure", "terraform"]
    nexus        = ["nexus", "sonatype-nexus", "nexus3", "sonatype-nexus3"]
    go           = ["go", "golang"]
    web          = ["javascript", "css", "html", "html5", "css3", "webapp"]
    python       = ["python", "python3"]
    vuejs        = ["vuejs", "vuejs3"]
    abandoned    = ["abandoned"]
  }
}
