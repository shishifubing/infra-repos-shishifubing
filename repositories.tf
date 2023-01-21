locals {
  # inject defaults into repositories
  repositories = {
    for name, config in local.repositories_initial :
    name => merge(local.repositories_defaults, config)
  }

  # defaults for repositories
  repositories_defaults = {
    template = {
      include_all_branches = true
      owner                = local.owner
      repository           = "template-${local.owner}-default"
    }
    branch_protections = {
      main = {
        enforce_admins                  = true
        required_approving_review_count = 0
      }
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

  # dictionary of topics to reuse
  topics = {
    common       = [local.owner]
    yandex_cloud = ["cloud", "yandex-cloud"]
    terraform    = ["infrastructure", "terraform", "terraform-module", "infrastructure-as-code"]
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
    shields      = ["shieldsio", "shields-io"]
    template     = ["template", "template-project", "template-repository"]
    packer       = ["packer"]
  }

  # main repository config
  repositories_initial = {
    "ci-actions-${local.owner}" = {
      description = join(" ", [
        "Github actions for ${local.owner} repositories"
      ])
      homepage_url = join("/", [
        local.owner_url, "ci-actions-${local.owner}"
      ])
      topics = concat(
        local.topics.common, local.topics.ghaction,
        []
      )
    }

    "template-${local.owner}-default" = {
      is_template = true
      description = join(" ", [
        "Default template for ${local.owner} repositories"
      ])
      homepage_url = join("/", [
        local.owner_url, "template-${local.owner}-default"
      ])
      topics = concat(
        local.topics.common, local.topics.shields, local.topics.template,
        []
      )
    }

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
        local.topics.packer,
        ["cloud-init"]
      )
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
    }

    "plugin-firefox-new-tab-bookmarks" = {
      archived = true
      description = join(" ", [
        "Plugin for Firefox, boring",
        "[abandoned]"
      ])
      homepage_url = join("/", [
        local.owner_url, "plugin-firefox-new-tab-bookmarks"
      ])
      topics = concat(
        local.topics.common, local.topics.web, local.topics.abandoned,
        ["javascript", "firefox", "firefox-addon"]
      )
    }

    "app-desktop-useless-cpp-gui" = {
      archived = true
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
    }

    "snippets-javascript-assignments" = {
      archived = true
      description = join(" ", [
        "Javascript assignments, boring",
      ])
      homepage_url = join("/", [
        local.owner_url, "snippets-javascript-assignments"
      ])
      topics = concat(
        local.topics.web, local.topics.common,
        []
      )
    }

    "app-web-crawler-book-creator" = {
      archived = true
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
    }

    "app-web-tianyi" = {
      archived = true
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
    }

    "app-cli-autoscroll" = {
      description = join(" ", [
        "Cross-platform CLI app enabling autoscroll",
        "[finished]"
      ])
      homepage_url = join("/", [
        "https://pypi.org/project", "autoscroll"
      ])
      topics = concat(
        local.topics.python, local.topics.common, local.topics.finished,
        ["pyqt5", "cli-app"]
      )
    }

    "app-web-django-assignment" = {
      archived = true
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
    }
  }
}
