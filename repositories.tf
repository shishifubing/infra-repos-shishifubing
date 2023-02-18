locals {
  # inject defaults into repositories
  repositories = {
    for name, config in local.repositories_initial :
    name => merge(local.repositories_defaults, config)
  }

  # defaults for repositories
  repositories_defaults = {}

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
    ci           = ["ci"]
    pages        = ["github-pages"]
  }

  # main repository config
  repositories_initial = {
    # github repositories
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

    "${local.owner}.github.io" = {
      description = join(" ", [
        "Website"
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

    # ci repositories
    "ci-actions-common" = {
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

    # infra repositories
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

    "infra-repos-${local.owner}" = {
      description = join(" ", [
        "Terraform module managing repositories in ${local.owner} organization"
      ])
      homepage_url = join("/", [
        local.owner_url, "infra-repos-${local.owner}"
      ])
      topics = concat(
        local.topics.common, local.topics.terraform,
        []
      )
    }

    # template repositories
    "template-repository-default" = {
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

    # miscellaneous repositories
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

    # snippets repositories
    "snippets-javascript-assignments" = {
      description = join(" ", [
        "Javascript assignments, boring",
      ])
      homepage_url = join("/", [
        local.site, "snippets-javascript-assignments/"
      ])
      topics = concat(
        local.topics.web, local.topics.common, local.topics.pages,
        []
      )
      pages = {}
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

    # plugin repositories
    "plugin-sonatype-nexus-security-check" = {
      description = join(" ", [
        "Security plugin for Sonatype Nexus 3"
      ])
      homepage_url = join("/", [
        local.owner_url, "plugin-sonatype-nexus-security-check"
      ])
      topics = concat(
        local.topics.nexus, local.topics.common, local.topics.finished,
        ["plugin", "java", "maven", "apache-karaf", "sonatype-nexus-plugin"]
      )
    }

    "plugin-firefox-new-tab-bookmarks" = {
      description = join(" ", [
        "Plugin for Firefox, boring"
      ])
      homepage_url = join("/", [
        local.owner_url, "plugin-firefox-new-tab-bookmarks"
      ])
      topics = concat(
        local.topics.common, local.topics.web, local.topics.abandoned,
        ["javascript", "firefox", "firefox-addon"]
      )
    }

    # app repositories
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

    "app-desktop-useless-cpp-gui" = {
      description = join(" ", [
        "Desktop GUI written using C++ and Qt, it does absolutely nothing"
      ])
      homepage_url = join("/", [
        local.owner_url, "app-desktop-useless-cpp-gui"
      ])
      topics = concat(
        local.topics.common, local.topics.abandoned, local.topics.ci,
        ["desktop-app", "gui", "qt", "cpp", "qt5", "appimage"]
      )
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
        local.topics.web, local.topics.webapp,
        ["django", "web-scraping"]
      )
    }

    "app-web-tianyi" = {
      description = join(" ", [
        "SPA CI/CD app"
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
        "Cross-platform CLI app enabling autoscroll"
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
      description = join(" ", [
        "SSR web app I built for a Fullstack Python Web Developer course"
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
  }
}
