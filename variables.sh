#!/usr/bin/env bash

dir="${HOME}/Credentials"
terraform_token="${dir}/yc/terraform-state-manager-token.txt"
github_token="${dir}/gh/shishifubing-token-repo-read:org.txt"

# second - secret key
# fist line in the file - key id
AWS_ACCESS_KEY_ID=$(sed -n 1p "${terraform_token}")
AWS_SECRET_ACCESS_KEY=$(sed -n 2p "${terraform_token}")
GITHUB_TOKEN=$(<"${github_token}")

export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY GITHUB_TOKEN