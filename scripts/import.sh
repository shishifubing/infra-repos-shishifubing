#!/usr/bin/env bash
set -Eeuxo pipefail

owner="${1:-shishifubing}"
bot="${2:-${owner}-bot}"

function import() {
    terraform import "${@}"
}

team_id=$(gh api "/orgs/${owner}/teams/admins" --jq .id)

import "github_membership.bot" "${owner}:${bot}"
import "github_organization_settings.organization" "${owner}"
import "github_team.admins" "${team_id}"
import "github_team_membership.bot" "${team_id}:${bot}"

mapfile -t repos < <(
    gh repo list "${owner}"                                     \
        --json "name"                                           \
        --template '{{ range . }}{{ .name }}{{ "\n" }}{{ end }}'
)

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

for repo in "${repos[@]}"; do
    import "module.repositories[\"${repo}\"].github_repository.repository" "${repo}"
    import                                                                                \
        "module.branch_protections_main[\"${repo}\"].github_branch_protection.protection" \
        "${repo}:main"
    import                                                                                    \
        "module.branch_protections_wildcard[\"${repo}\"].github_branch_protection.protection" \
        "${repo}:*"
    import "github_branch_default.default[\"${repo}\"]" "${repo}"
    import "github_team_repository.admins[\"${repo}\"]" "${team_id}:${repo}"
done

for repo in "${gitlab_repos[@]}"; do
    # gitlab's repository names cannot start with a special character
    repo_name="${repo}"
    [[ "${repo:0:1}" == "." ]] && repo_name="dot-${repo:1}"
    import "gitlab_project.repositories[\"${repo}\"]" "${owner}/${repo_name}"
done