#!/bin/bash

EXT_DIR="wiki/extensions"
VE_DIR="$EXT_DIR/VisualEditor"
VE_REPO="https://gerrit.wikimedia.org/r/mediawiki/extensions/VisualEditor"
CE_DIR="$EXT_DIR/ConfirmEdit"
CE_REPO="https://gerrit.wikimedia.org/r/mediawiki/extensions/ConfirmEdit"

mkdir -p "$EXT_DIR" || exit 0

ensure_repo() {
	local dir="$1"
	local repo="$2"
	local branch="$3"

	if [ -d "$dir/.git" ]; then
		(
			cd "$dir" && \
			git fetch origin "$branch" >/dev/null 2>&1 && \
			git checkout "$branch" >/dev/null 2>&1 && \
			git pull --rebase >/dev/null 2>&1 && \
			git submodule update --init --recursive >/dev/null 2>&1
		) || true
	else
		(
			cd "$(dirname "$dir")" && \
			git clone --branch "$branch" --recurse-submodules "$repo" >/dev/null 2>&1
		) || true
	fi
}

ensure_repo "$VE_DIR" "$VE_REPO" "REL1_43"
ensure_repo "$CE_DIR" "$CE_REPO" "REL1_43"

