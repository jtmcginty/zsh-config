# hooks.zsh
# Shell hooks wired via add-zsh-hook. Runs after all tools are initialized.

autoload -Uz add-zsh-hook

# ── tmux bell on long-running commands (>10s) ────────────────────────────────
# Fires a terminal bell after any command that takes longer than 10 seconds.
# tmux-session-dots picks this up via monitor-bell to highlight the session.
_cmd_start=0
_tmux_bell_preexec() { _cmd_start=$SECONDS }
_tmux_bell_precmd()  { (( _cmd_start > 0 && SECONDS - _cmd_start > 10 )) && printf "\a" }
add-zsh-hook preexec _tmux_bell_preexec
add-zsh-hook precmd  _tmux_bell_precmd
