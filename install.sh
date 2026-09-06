#!/bin/sh
# Public one-liner entrypoint for jessieroman/dotfiles (that repo is
# private, so its own install.sh can't be curl|sh'd directly -- see
# jessieroman/dotfiles/README.md's "Already have SSH access" section).
#
#   curl -fsSL https://raw.githubusercontent.com/jessieroman/dotfiles-bootstrap/main/install.sh | sh
#
# Kept deliberately tiny and stable: clone/update the private repo over
# SSH, then hand off entirely to its own install.sh. Every actual install
# decision (which tools, the TUI checklist, chezmoi) lives there and can
# change freely without ever touching this URL or this file.
#
# Needs this machine's SSH key already added to GitHub (git clone auth).
# No GitHub token/PAT needed -- this repo is public.
set -eu

repo_url="${DOTFILES_REPO_URL:-git@github.com:jessieroman/dotfiles.git}"
dest="${DOTFILES_DIR:-$HOME/git/dotfiles}"

log() { printf '\033[1;32m==>\033[0m %s\n' "$1"; }
die() { printf '\033[1;33m!!\033[0m %s\n' "$1" >&2; exit 1; }

command -v git >/dev/null 2>&1 || die "install.sh: git is required (clone/update the dotfiles repo)"

if [ -d "$dest/.git" ]; then
  log "updating existing clone at $dest"
  git -C "$dest" pull --ff-only
else
  log "cloning $repo_url to $dest"
  mkdir -p "$(dirname "$dest")"
  git clone "$repo_url" "$dest"
fi

log "handing off to $dest/install.sh"
cd "$dest"
exec sh install.sh "$@"
