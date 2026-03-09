# zsh dotfiles

## Structure

```
~/.zshenv                        # → sources zsh-config/env.zsh (every zsh invocation)
~/.zprofile                      # → sources zsh-config/path.zsh (login shells only)
~/.zshrc                         # → sources zsh-config/* in order (interactive shells)

~/.config/zsh/
    env.zsh                      # XDG dirs, EDITOR, LANG, PAGER — universal
    path.zsh                     # Homebrew, PATH, compiler flags, SDKMAN — login-time
    history.zsh                  # history size, dedup, sharing
    plugins.zsh                  # p10k, syntax highlighting, autosuggestions
    completion.zsh               # compinit, zstyle, kubectl/helm/docker/terraform
    aliases.zsh                  # all aliases
    functions.zsh                # search(), gi(), mkcd(), port(), epoch()
    tools.zsh                    # pyenv, nvm lazy load, fzf, bat, ripgrep, docker
    secrets.zsh                  # sources ~/.secrets/* — never committed
```

## Setup

```zsh
# Clone your dotfiles repo
git clone <your-repo> ~/dotfiles

# Symlink top-level zsh files
ln -sf ~/dotfiles/zshenv ~/.zshenv
ln -sf ~/dotfiles/zprofile ~/.zprofile
ln -sf ~/dotfiles/zshrc ~/.zshrc

# Symlink config directory
mkdir -p ~/.config
ln -sf ~/dotfiles/zsh-config ~/.config/zsh

# Create secrets directory (never committed)
mkdir -p ~/.secrets
chmod 700 ~/.secrets
# copy secrets-example/* to ~/.secrets/ and fill in values
```

## What's not committed

`~/.secrets/` — create this manually on each machine and populate with:
- `postgres.sh` — POSTGRESQL_PASSWORD
- `tokens.sh` — API keys, personal access tokens
- `work.sh` — work-specific env vars

## Key decisions

**Oh-My-Zsh dropped** — plugins are sourced directly via Homebrew. Faster startup,
no magic, easier to debug. OMZ plugin equivalents are noted in plugins.zsh.

**nvm lazy-loaded** — nvm adds ~300-500ms to shell startup if sourced eagerly.
The lazy loader in tools.zsh defers init until you actually run node/npm/nvm.

**SDKMAN in zprofile** — slow init that only needs to run once per login session,
not on every new tab. Replaces jenv entirely.

**gvm dropped** — use Homebrew-managed Go or goenv (see tools.zsh).

**Compiler flags merged** — openssl and tcl-tk LDFLAGS/CPPFLAGS/PKG_CONFIG_PATH
are combined in path.zsh to prevent one clobbering the other.

**`reload` uses `exec zsh`** — cleaner than `source ~/.zshrc` which only partially
reloads and can leave stale state.
