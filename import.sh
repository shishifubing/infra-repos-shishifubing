#!/usr/bin/env bash
set -Eeuxo pipefail

owner="${1:-shishifubing}"

template_name="{{ range . }}{{ .name }} {{ end }}"

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
    terraform import                                                    \
        "module.repositories[\"${repo}\"].github_repository.repository" \
        "${repo}"
    terraform import                                                                      \
        "module.branch_protections_main[\"${repo}\"].github_branch_protection.protection" \
        "${repo}:main"
    terraform import                                                                          \
        "module.branch_protections_wildcard[\"${repo}\"].github_branch_protection.protection" \
        "${repo}:*"
    terraform import                                 \
        "github_branch_default.default[\"${repo}\"]" \
        "${repo}"
done

for repo in "${gitlab_repos[@]}"; do
    # gitlab repository names cannot start with a special character
    repo_name="${repo}"
    [[ "${repo:0:1}" == "." ]] && repo_name="dot-${repo:1}"
    terraform import                            \
        "gitlab_project.repositories[\"${repo}\"]" \
        "${owner}/${repo_name}"
done