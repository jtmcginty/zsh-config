# aliases.zsh

# ── Navigation ────────────────────────────────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."        # fixed: ../../ is not a valid alias name
alias ....="cd ../../.."    # fixed: ../../../ is not a valid alias name

# ── Shell ─────────────────────────────────────────────────────────────────────
alias x="exit"
alias reload="exec zsh"     # exec zsh starts a fresh shell — cleaner than sourcing

# ── Listing ───────────────────────────────────────────────────────────────────
alias ll="exa -bghHliS"
alias la="ll -a"

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

# ── Function aliases (makes them visible in `alias` output) ──────────────────
alias search=search
alias gi=gi
