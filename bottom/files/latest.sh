#!/usr/bin/env bash
set -euo pipefail

DISTRO="${1:?Usage: latest.sh <distro> [dest_dir]}"
DEST_DIR="${2:-/tmp}"

BTM_VERSION=$(curl -sI https://github.com/ClementTsang/bottom/releases/latest \
  | grep -i ^location: | sed 's|.*/||' | tr -d '\r\n')

if [ -z "$BTM_VERSION" ]; then
  echo "Failed to determine latest bottom version" >&2
  exit 1
fi

echo "Latest bottom version: ${BTM_VERSION}"

case "${DISTRO}" in
  Ubuntu|"Linux Mint")
    URL="https://github.com/ClementTsang/bottom/releases/download/${BTM_VERSION}/bottom_${BTM_VERSION}-1_amd64.deb"
    DEST="${DEST_DIR}/bottom.deb"
    ;;
  Fedora)
    URL="https://github.com/ClementTsang/bottom/releases/download/${BTM_VERSION}/bottom-${BTM_VERSION}-1.x86_64.rpm"
    DEST="${DEST_DIR}/bottom.rpm"
    ;;
  *)
    echo "Unsupported distribution: ${DISTRO}" >&2
    exit 1
    ;;
esac

echo "Downloading ${URL}"
curl -sLo "${DEST}" "${URL}"
echo "Saved to ${DEST}"
