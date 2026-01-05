#!/usr/bin/env bash

set -e

COMMIT_MSG="Config-change $(date '+%Y-%m-%d %H:%M:%S')"

git add -A

if git diff-index --quit HEAD --; then
	echo "No changes to commit."
else
	 git commit -m "$COMMIT_MSG"
	 echo "Committed changes with message: '$COMMIT_MSG'"
fi

sudo nixos-rebuild switch --flake /home/kybe/.dotfiles#knx

echo "NixOS flake reloaded!"
