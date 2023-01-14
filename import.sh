#!/usr/bin/env bash
set -Eeuxo pipefail

skip_repos="${1:-false}"
skip_branch_protection="${2:-false}"
owner="${3:-shishifubing-com}"

template_name="{{ range . }}{{ .name }} {{ end }}"
template_pattern="{{ range .data.repository.branchProtectionRules.nodes }}{{ .pattern }} {{ end }}"

function resource_repository() {
    echo "module.repositories[\"${1}\"].github_repository.repository"
}

function resource_rule() {
    echo "module.branch_protections[\"${1}\"].github_branch_protection.protection"
}

repos=$(
    gh repo list "${owner}"           \
        --json "name"                 \
        --template "${template_name}"
)
read -ra repos <<<"${repos}"

for repo in "${repos[@]}"; do
    [[ "${skip_repos}" == "false" ]] &&
        terraform import                       \
            "$(resource_repository "${repo}")" \
            "${repo}"
    [[ "${skip_branch_protection}" != "false" ]] && continue
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