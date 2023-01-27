#!/usr/bin/env bash
set -Eeuxo pipefail

owner="${1:-shishifubing}"

template_name="{{ range . }}{{ .name }} {{ end }}"
template_pattern="{{ range .data.repository.branchProtectionRules.nodes }}{{ .pattern }} {{ end }}"

function resource_repository() {
    echo "module.repositories[\"${1}\"].github_repository.repository"
}

function resource_rule() {
    echo "module.branch_protections[\"${1}\"].github_branch_protection.protection"
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

    patterns=$(
        gh api graphql                                               \
            --raw-field query="{
                repository(owner: \"${owner}\", name: \"${repo}\") {
                    branchProtectionRules(first:100) {
                        nodes {
                            pattern
                        }
                    }
                }
            }"                                                       \
            --template "${template_pattern}"
    )
    read -ra patterns <<<"${patterns}"
    for pattern in "${patterns[@]}"; do
        terraform import                            \
            "$(resource_rule "${repo}/${pattern}")" \
            "${repo}:${pattern}"
    done
done

for repo in "${gitlab_repos[@]}"; do
    # gitlab repository names cannot start with a special character
    repo_name="${repo}"
    [[ "${repo:0:1}" == "." ]] && repo_name="dot-${repo:1}"
    terraform import                   \
        "$(resource_gitlab "${repo}")" \
        "${owner}/${repo_name}"
done