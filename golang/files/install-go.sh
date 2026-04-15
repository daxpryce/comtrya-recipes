#!/bin/bash
set -euo pipefail

# Skip if Go is already installed at the expected location
if command -v /usr/local/go/bin/go &>/dev/null; then
    echo "Go is already installed: $(/usr/local/go/bin/go version)"
    exit 0
fi

LATEST_VERSION=$(curl -fsSL 'https://go.dev/VERSION?m=text' | head -1)
TARBALL="${LATEST_VERSION}.linux-amd64.tar.gz"
URL="https://go.dev/dl/${TARBALL}"

echo "Installing ${LATEST_VERSION}..."
curl -fsSL -o "/tmp/${TARBALL}" "${URL}"
tar -C /usr/local -xzf "/tmp/${TARBALL}"
rm -f "/tmp/${TARBALL}"

echo "Installed: $(/usr/local/go/bin/go version)"
