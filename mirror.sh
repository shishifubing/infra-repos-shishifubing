#!/usr/bin/env bash
set -Eeuxo pipefail

repos=$(terraform output -json "repositories")
replace=$(
    jq -r '
        to_entries |
        map("-replace=gitlab_project.repository[\"\(.key)\"]") |
        join(" ")
    ' <<<"${repos}"
)
read -ra replace <<<"${replace}"
terraform apply "${replace[@]}" "${@}"