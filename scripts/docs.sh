#!/usr/bin/env bash
set -Eeuxo pipefail

terraform-docs markdown table --recursive --output-file README.md .