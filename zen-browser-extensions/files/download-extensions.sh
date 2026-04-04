#!/usr/bin/env bash
# Downloads the latest XPI for each extension from AMO.
# Requires: bash, curl, python3
set -euo pipefail

EXTENSIONS_DIR="/opt/zen/browser/extensions"

download_extension() {
    local slug="$1"
    local guid="$2"
    local dest="${EXTENSIONS_DIR}/${guid}.xpi"

    echo "==> Fetching latest '${slug}' from AMO..."
    local url
    url=$(curl -sf "https://addons.mozilla.org/api/v5/addons/addon/${slug}/" \
        | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['current_version']['file']['url'])")

    echo "    URL: ${url}"
    echo "    Dest: ${dest}"
    curl -sL --fail "${url}" -o "${dest}"
    echo "    Done."
}

download_extension "ublock-origin"               "uBlock0@raymondhill.net"
download_extension "bitwarden-password-manager"  "{446900e4-71c2-419f-a6a7-df9c091e268b}"
download_extension "kagi-search-for-firefox"     "search@kagi.com"
