# env.zsh
# Sourced via zshenv — available in ALL zsh contexts including scripts and cron.
# Only put things that must exist universally. No evals, no slow operations.

# ── XDG Base Directories ─────────────────────────────────────────────────────
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# ── Editor ────────────────────────────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"

# ── Locale — explicit UTF-8 prevents silent encoding bugs ────────────────────
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ── Terminal color ────────────────────────────────────────────────────────────
export COLORTERM="truecolor"
export TERM="xterm-256color"

# ── Pager ─────────────────────────────────────────────────────────────────────
export PAGER="less"
export MANPAGER="less -R"
# -R  pass color codes through
# -F  auto-exit if content fits on screen
# -X  don't clear screen on exit
# -i  case-insensitive search
# -M  verbose prompt with line numbers
export LESS="-RFXiM"
