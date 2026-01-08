#!/usr/bin/env nix-shell
#!nix-shell -i bash -p git nixfmt nixfmt-tree nix

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
FLAKE_REF="knx"

COMMIT_MSG="${1:-Config-change $(date '+%Y-%m-%d %H:%M:%S')}"

cd "$DOTFILES_DIR" || { echo "Failed to enter $DOTFILES_DIR"; exit 1; }

echo "Formatting files"
if treefmt; then
  echo "Files formatted successfully."
else
  echo "File formatting failed!" >&2
  exit 1
fi

git add -A

if git diff-index --quiet HEAD --; then
  echo "No changes to commit."
  CHANGES=0
else
  git commit -m "$COMMIT_MSG"
  echo "Committed changes with message: '$COMMIT_MSG'"
  CHANGES=1
fi

if [[ $CHANGES -eq 1 ]]; then
  echo "Testing NixOS rebuild..."
  if sudo nixos-rebuild switch --flake "$DOTFILES_DIR#$FLAKE_REF"; then
    git push github
    git push codeberg
    echo "Changes pushed!"
  else
    echo "NixOS rebuild failed, not pushing changes!" >&2
    exit 1
  fi
else
  echo "No changes to commit, nothing to rebuild or push."
fi
