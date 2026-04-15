#!/bin/bash
set -euo pipefail

# Skip if rustup is already installed
if command -v rustup &>/dev/null; then
    echo "Rust is already installed: $(rustc --version)"
    rustup update
    exit 0
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
