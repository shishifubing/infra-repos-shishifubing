#!/usr/bin/env bash
set -Eeuxo pipefail

mapfile -t resources < <(terraform state list)
terraform state rm "${resources[@]}"