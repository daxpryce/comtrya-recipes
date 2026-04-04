#!/usr/bin/env bash
# Bootstrap script: downloads the latest comtrya release and runs it.
# Requires: bash, curl (or wget), sudo
set -euo pipefail

ASSET="comtrya-x86_64-unknown-linux-gnu"
DOWNLOAD_URL="https://github.com/comtrya/comtrya/releases/latest/download/${ASSET}"
INSTALL_PATH="/usr/local/bin/comtrya"
TMP_BIN="$(mktemp)"

cleanup() { rm -f "${TMP_BIN}"; }
trap cleanup EXIT

echo "==> Downloading latest comtrya..."
if command -v curl &>/dev/null; then
    curl -fsSL "${DOWNLOAD_URL}" -o "${TMP_BIN}"
elif command -v wget &>/dev/null; then
    wget -qO "${TMP_BIN}" "${DOWNLOAD_URL}"
else
    echo "Error: neither curl nor wget is available." >&2
    exit 1
fi

chmod +x "${TMP_BIN}"

echo "==> Installing comtrya to ${INSTALL_PATH}..."
sudo install -m 0755 "${TMP_BIN}" "${INSTALL_PATH}"

echo "==> comtrya $(comtrya version) installed."
