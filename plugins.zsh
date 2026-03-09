# plugins.zsh
# Prompt, syntax highlighting, autosuggestions — no Oh-My-Zsh.
# Everything sourced directly via Homebrew. Faster, more transparent, easier to debug.
#
# One-time install:
#   brew install powerlevel10k
#   brew install zsh-syntax-highlighting
#   brew install zsh-autosuggestions
#   brew install zsh-history-substring-search
#   brew install direnv

# ── Powerlevel10k instant prompt ──────────────────────────────────────────────
# Must be near the top of zshrc, before any output. Already handled in zshrc.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# ── Powerlevel10k theme ───────────────────────────────────────────────────────
source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ── Syntax highlighting — must come before autosuggestions ───────────────────
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[unknown-command]='fg=red'

# ── Autosuggestions ───────────────────────────────────────────────────────────
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ── History substring search ──────────────────────────────────────────────────
source "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^[[A' history-substring-search-up     # up arrow
bindkey '^[[B' history-substring-search-down   # down arrow

# ── ls colors ─────────────────────────────────────────────────────────────────
export CLICOLOR=1
export LSCOLORS="ExGxFxDxCxDxDxhbhdacad"       # macOS/BSD ls
export LS_COLORS="di=1;34:ln=1;36:ex=1;32:*.tar=1;31:*.zip=1;31"  # Linux/GNU ls

# ── direnv — auto-load/unload .envrc on cd ───────────────────────────────────
# This is what makes per-project env vars work automatically.
# Usage: add .envrc to a project dir, run `direnv allow` once, done.
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# ── What the OMZ plugins were actually doing (now handled directly) ───────────
# git:     completions come from zsh built-in + compinit
# docker:  completions come from Docker Desktop install
# brew:    Homebrew auto-configures its own zsh completions on install
# gradle:  completions via SDKMAN-managed gradle
# npm/yarn: run `npm completion >> ~/.config/zsh/completion.zsh` once to bake in
# macos:   if you use tab/ofd/pfd, copy just those functions into functions.zsh
# ng:      add back only if doing active Angular work
