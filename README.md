# zsh dotfiles

## Structure

```
~/.zshenv                        # -> sources zsh-config/env.zsh (every zsh invocation)
~/.config/zsh/.zprofile          # -> sources zsh-config/path.zsh (login shells only)
~/.config/zsh/.zshrc             # -> sources zsh-config/* in order (interactive shells)

~/.config/zsh/
    env.zsh                      # XDG dirs, EDITOR, LANG, PAGER -- universal
    path.zsh                     # Homebrew, PATH, compiler flags, SDKMAN -- login-time
    history.zsh                  # history size, dedup, sharing
    plugins.zsh                  # p10k, syntax highlighting, autosuggestions, direnv
    completion.zsh               # compinit, zstyle, kubectl/helm/docker/terraform
    aliases.zsh                  # all aliases
    functions.zsh                # _search(), _gi(), mkcd(), port(), epoch()
    tools.zsh                    # pyenv, nvm lazy load, fzf, bat, ripgrep, docker
    secrets.zsh                  # sources ~/.secrets/* -- never committed

~/.secrets/                      # NOT in repo -- create manually on each machine
    postgres.sh                  # POSTGRESQL_PASSWORD, etc
    tokens.sh                    # API keys, personal access tokens
    work.sh                      # work-specific env vars
```

## Setup

```zsh
# Clone your dotfiles repo
git clone <your-repo> ~/dotfiles

# zshenv lives at ~ because it loads before ZDOTDIR is set
ln -sf ~/dotfiles/zshenv ~/.zshenv

# zshrc and zprofile live at ZDOTDIR because zshenv sets ZDOTDIR=$HOME/.config/zsh
# and zsh looks there for all subsequent dotfiles
ln -sf ~/dotfiles/zshrc ~/.config/zsh/.zshrc
ln -sf ~/dotfiles/zprofile ~/.config/zsh/.zprofile

# Install brew dependencies
brew install powerlevel10k
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions
brew install zsh-history-substring-search
brew install direnv

# Create secrets directory (never committed)
mkdir -p ~/.secrets
chmod 700 ~/.secrets
# populate ~/.secrets/ with your secret files (see secrets-example/)

# Run p10k setup if needed
p10k configure
```

## Why zshenv goes in ~ but zshrc/zprofile go in ZDOTDIR

zsh reads ~/.zshenv before ZDOTDIR is set. Once zshenv runs and sets
ZDOTDIR=$HOME/.config/zsh, all subsequent dotfiles (.zshrc, .zprofile, .zlogin)
are looked up in ZDOTDIR, not ~. This is why the symlinks go to different places.

## Secrets vs direnv

**~/.secrets/** -- global identity. Things true about you on this machine regardless
of what project you're working on. Local Postgres password, personal API tokens, etc.

**direnv + .envrc** -- project context. Things only true inside a specific project.

```bash
# Example: ~/projects/myapp/.envrc
export DATABASE_URL="postgres://localhost:5432/myapp_dev"
export AWS_PROFILE="myapp-staging"
export NODE_ENV="development"
```

First time you create or edit a .envrc, run `direnv allow` once. direnv will
automatically load it on cd in and unload it on cd out. Commit .envrc.example
with placeholder values; gitignore the real .envrc if it contains sensitive values.

## Key decisions

**Oh-My-Zsh dropped** -- p10k, syntax highlighting, autosuggestions, and history
substring search are all installed directly via Homebrew. Faster startup, no magic,
easier to debug.

**nvm lazy-loaded** -- nvm adds ~300-500ms to shell startup if sourced eagerly.
The lazy loader in tools.zsh defers init until you actually run node/npm/nvm/yarn.

**SDKMAN in zprofile** -- slow init that only needs to run once per login session.
Replaces jenv entirely.

**gvm dropped** -- use Homebrew-managed Go or goenv (see tools.zsh for goenv setup).

**Compiler flags merged** -- openssl and tcl-tk LDFLAGS/CPPFLAGS/PKG_CONFIG_PATH
are combined in path.zsh to prevent one clobbering the other.

**path.zsh is idempotent** -- guarded with _PATH_LOADED flag so duplicate sourcing
does not produce duplicate PATH entries.

**reload uses exec zsh** -- cleaner than source ~/.zshrc which only partially
reloads and can leave stale state.

