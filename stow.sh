#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/dotfiles" && pwd)"

for pkg in "$DOTFILES_DIR"/*/; do
  pkg_name="$(basename "$pkg")"
  echo "stowing $pkg_name"
  stow --target="$HOME" --dir="$DOTFILES_DIR" "$pkg_name"
done
