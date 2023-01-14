#!/usr/bin/env bash

dir="${HOME}/Credentials"
terraform_token="${dir}/yc/terraform-state-manager-token.txt"
github_token="${dir}/gh/shishifubing-token-repo-read:org.txt"
gitlab_token="${dir}/gitlab/personal_api.txt"

# s3 bucket token, fist line in the file - key id, second - secret key
AWS_ACCESS_KEY_ID=$(sed -n 1p "${terraform_token}")
AWS_SECRET_ACCESS_KEY=$(sed -n 2p "${terraform_token}")
# other tokens
GITHUB_TOKEN=$(<"${github_token}")
GITLAB_TOKEN=$(<"${gitlab_token}")

export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY GITHUB_TOKEN GITLAB_TOKEN