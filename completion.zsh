# completion.zsh
# Tab completion setup. Must run after plugins.zsh.

# ── compinit with caching ─────────────────────────────────────────────────────
# Only rebuilds completion cache if it's older than 24 hours — much faster
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# ── Completion behavior ───────────────────────────────────────────────────────
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' menu select                            # arrow-key menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"      # colored completions
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'

# ── Tool-specific completions ─────────────────────────────────────────────────
# kubectl
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

# helm
if command -v helm &>/dev/null; then
  source <(helm completion zsh)
fi

# docker (if not already handled by Docker Desktop)
if command -v docker &>/dev/null; then
  source <(docker completion zsh 2>/dev/null)
fi

# terraform
if command -v terraform &>/dev/null; then
  autoload -Uz bashcompinit && bashcompinit
  complete -o nospace -C terraform terraform
fi
