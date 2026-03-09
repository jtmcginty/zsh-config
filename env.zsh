# env.zsh
# Sourced via zshenv — available in ALL zsh contexts including scripts, cron,
# tmux panes, and non-login shells.
# No PATH manipulation here — macOS path_helper runs after zshenv and would
# reorder it anyway. PATH is set in path.zsh (zprofile) after path_helper fires.

# ── XDG Base Directories ──────────────────────────────────────────────────────
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
