#!/bin/bash
# Idempotently add .bashrc.d sourcing to ~/.bashrc

BASHRC="$HOME/.bashrc"
MARKER="# Source scripts from ~/.bashrc.d"

if ! grep -qF "$MARKER" "$BASHRC" 2>/dev/null; then
    cat >> "$BASHRC" << 'EOF'

# Source scripts from ~/.bashrc.d
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
    unset rc
fi
EOF
fi
