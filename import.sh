#!/usr/bin/env bash
set -Eeuxo pipefail

repos=$(
    gh repo list shishifubing-com                        \
        --json 'name'                                    \
        --template '{{ range . }}{{ .name }} {{ end }}'
)
read -ra repos <<<"${repos}"
for repo in "${repos[@]}"; do
    terraform import "github_repository.repositories[\"${repo}\"]" "${repo}"
done