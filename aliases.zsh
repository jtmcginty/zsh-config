# aliases.zsh

# ── Navigation ────────────────────────────────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# ── Shell ─────────────────────────────────────────────────────────────────────
alias x="exit"
alias reload="exec zsh"

# ── Listing ───────────────────────────────────────────────────────────────────
alias ll="eza --long --icons=auto --header --group-directories-first --git --binary"
alias la="ll --all"

# ── History ───────────────────────────────────────────────────────────────────
alias hc="history -c"
alias hg="history | grep "

# ── Tools ─────────────────────────────────────────────────────────────────────
alias tf="terraform"
alias kiro="kiro-cli"
alias docker-compose="docker compose"

# ── Fuzzy find filenames ──────────────────────────────────────────────────────
alias fuz='fd --type f | fzf --ansi \
  --bind "enter:execute(nvim {})" \
  --preview "
    if [[ {} == *.html ]] || [[ {} == *.htm ]]; then
      lynx -dump -width=\$FZF_PREVIEW_COLUMNS -nolist {} 2>/dev/null || \
        bat --color=always --style=numbers --line-range=:500 {}
    else
      bat --color=always --style=numbers --line-range=:500 {}
    fi"'

# ── Local AI agent ────────────────────────────────────────────────────────────
alias ai='ollmcp \
  --model my-coder \
  --servers-json ~/.config/ollmcp/mcp-servers/config.json'

# ── Function aliases ──────────────────────────────────────────────────────────
# These point to underscore-prefixed functions in functions.zsh.
# Defined as aliases so they appear in `alias` output as a reminder they exist.
alias search='_search'
alias gi='_gi'
