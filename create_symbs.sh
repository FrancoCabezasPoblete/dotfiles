#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-"$HOME/.config"}"

link_zsh_into_home() {
	local zsh_dir="$1"
	# Normalize: remove any trailing slash to avoid paths like zsh//.zshrc
	zsh_dir="${zsh_dir%/}"

	echo "Linking zsh files from $zsh_dir to $HOME"

	# Include dotfiles like .zshrc, .zprofile, etc.
	for item in "$zsh_dir"/.* "$zsh_dir"/*; do
		# Skip if glob didn't match or it's . or ..
		[ -e "$item" ] || continue
		name="$(basename "$item")"
		[ "$name" = "." ] && continue
		[ "$name" = ".." ] && continue

		local target
		target="$HOME/$name"

		if [ -e "$target" ] && [ ! -L "$target" ]; then
			echo "[skip] $target exists and is not a symlink"
			continue
		fi

		if [ -L "$target" ] && [ "$(readlink -f "$target")" != "$(readlink -f "$item")" ]; then
			echo "[warn] $target is a symlink to a different location; replacing"
			rm -f "$target"
		fi

		ln -sfn "$item" "$target"
		echo "[link] $target -> $item"
	done
}

echo "Linking configs from $SCRIPT_DIR to $CONFIG_DIR and zsh files to $HOME"

mkdir -p "$CONFIG_DIR"

for dir in "$SCRIPT_DIR"/*/; do
	# Skip if glob doesn't match anything
	[ -d "$dir" ] || continue

	name="$(basename "$dir")"

	# Special handling for zsh: link files into $HOME instead of ~/.config/zsh
	if [ "$name" = "zsh" ]; then
		link_zsh_into_home "$dir"
		continue
	fi

	# Skip script-related or non-config folders explicitly if needed
	case "$name" in
		".git"|".github")
			continue
			;;
	esac

	target="$CONFIG_DIR/$name"

	# If target already exists and is not a symlink, skip to avoid clobbering
	if [ -e "$target" ] && [ ! -L "$target" ]; then
		echo "[skip] $target exists and is not a symlink"
		continue
	fi

	# If it's a symlink pointing somewhere else, warn and replace
	if [ -L "$target" ] && [ "$(readlink -f "$target")" != "$(readlink -f "$dir")" ]; then
		echo "[warn] $target is a symlink to a different location; replacing"
		rm -f "$target"
	fi

	# Create / refresh symlink
	ln -sfn "$dir" "$target"
	echo "[link] $target -> $dir"
done

echo "Done."

