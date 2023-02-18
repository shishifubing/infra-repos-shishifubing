#!/usr/bin/env bash
set -Eeuxo pipefail

owner="${1:-shishifubing}"

template_name="{{ range . }}{{ .name }} {{ end }}"

function resource_repository() {
    echo "module.repositories[\"${1}\"].github_repository.repository"
}

function resource_rule_main() {
    echo "module.branch_protections_main[\"${1}\"].github_branch_protection.protection"
}

function resource_rule_wildcard() {
    echo "module.branch_protections_wildcard[\"${1}\"].github_branch_protection.protection"
}

function resource_gitlab() {
    echo "gitlab_project.repositories[\"${1}\"]"
}

repos=$(
    gh repo list "${owner}"           \
        --json "name"                 \
        --template "${template_name}"
)
read -ra repos <<<"${repos}"

mapfile -t gitlab_repos < <(
    glab api graphql --field query="
        query(\$endCursor: String) {
            group(fullPath: \"${owner}\") {
                projects(after: \$endCursor) {
                    pageInfo {
                        endCursor
                        startCursor
                        hasNextPage
                    }
                    nodes {
                        name
                        visibility
                    }
                }
            }
        }
    " | jq -r '
        .data.group.projects.nodes[]                  |
            select(.visibility == "public")           |
            select(.name | contains("deleted") | not) |
            .name
    '
)

terraform import                \
    "github_membership.bot"     \
    "${owner}:shishifubing-bot"

terraform import                                \
    "github_organization_settings.organization" \
    "${owner}"

for repo in "${repos[@]}"; do
    terraform import                       \
        "$(resource_repository "${repo}")" \
        "${repo}"

    terraform import                      \
        "$(resource_rule_main "${repo}")" \
        "${repo}:main"
    terraform import                          \
        "$(resource_rule_wildcard "${repo}")" \
        "${repo}:*"
    terraform import "github_branch_default.default[\"${repo}\"]" "main"
done

for repo in "${gitlab_repos[@]}"; do
    # gitlab repository names cannot start with a special character
    repo_name="${repo}"
    [[ "${repo:0:1}" == "." ]] && repo_name="dot-${repo:1}"
    terraform import                   \
        "$(resource_gitlab "${repo}")" \
        "${owner}/${repo_name}"
done