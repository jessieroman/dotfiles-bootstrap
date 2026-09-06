# dotfiles-bootstrap

Public one-liner entrypoint for [jessieroman/dotfiles](https://github.com/jessieroman/dotfiles)
(private). GitHub has no per-file visibility — a private repo can't
serve one public raw file — so this tiny public repo exists purely to
give the private repo's install a stable, unauthenticated `curl | sh`
URL:

```bash
curl -fsSL https://raw.githubusercontent.com/jessieroman/dotfiles-bootstrap/main/install.sh | sh
```

`install.sh` here does exactly one thing: clone or update
`jessieroman/dotfiles` over SSH into `~/git/dotfiles` (override with
`DOTFILES_DIR`/`DOTFILES_REPO_URL`), then exec that repo's own
`install.sh`. Every actual install decision — which tools, the TUI
checklist, chezmoi — lives in the private repo and can change freely
without ever touching this file or its URL.

Requires this machine's SSH key already added to GitHub (same
prerequisite `git clone git@github.com:...` always has). No GitHub
token/PAT needed — this repo is public.

Nothing sensitive lives here on purpose: no secrets, no other
machine-specific config. Just the pull-and-handoff step.
