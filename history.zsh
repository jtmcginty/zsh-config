# history.zsh
# History behavior — interactive shells only (lives in zshrc load order).

export HISTFILE="$XDG_STATE_HOME/zsh/history"   # store history under XDG state, not home
export HISTSIZE=100000
export SAVEHIST=100000

# Remove older duplicate entries, share history across sessions
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY                               # show expanded history before executing

# Create history dir if it doesn't exist
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"
