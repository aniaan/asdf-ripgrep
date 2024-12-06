#!/usr/bin/env bash

REPO_NAME="BurntSushi/ripgrep"
GITHUB_BASE_URL="https://github.com"
GITHUB_API_BASE_URL="https://api.github.com"

get_github_api_releases_url() {
    echo "${GITHUB_API_BASE_URL}/repos/${REPO_NAME}/releases"
}


get_release_url() {
    local version=$1
    local filename=$2
    echo "${GITHUB_BASE_URL}/${REPO_NAME}/releases/download/${version}/${filename}"
}


list_all_versions() {
    local cmd="curl -s"
    local response

    response=$($cmd "$(get_github_api_releases_url)")
    versions=$(echo "$response" | \
        jq -r '.[].tag_name' | \
        grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | \
        sort -V | \
        tr '\n' ' ' | \
        sed 's/ $//')

    if [ -z "$versions" ]; then
        echo "Unable to fetch ripgrep versions from GitHub" >&2
        return 1
    fi

    echo "$versions"
}
