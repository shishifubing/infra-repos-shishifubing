#!/usr/bin/env bash
set -Eeuxo pipefail

read -ra args < <(terraform state list)
terraform state rm "${args[@]}"