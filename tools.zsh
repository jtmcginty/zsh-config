# tools.zsh
# Dev tool initialization — interactive shells only.
# Lazy-loaded where possible to keep startup fast.

# ── pyenv ─────────────────────────────────────────────────────────────────────
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init -)"
  # Uncomment if you use pyenv-managed virtualenvs directly (adds latency)
  # Poetry handles most virtualenv needs, so this is off by default
  # eval "$(pyenv virtualenv-init -)"
fi

# ── nvm — lazy loaded ─────────────────────────────────────────────────────────
# nvm, node, npm, npx won't initialize until first use — saves ~300-500ms
export NVM_DIR="$HOME/.nvm"
_nvm_commands=("nvm" "node" "npm" "npx" "yarn" "pnpm")
_nvm_load() {
  for _cmd in "${_nvm_commands[@]}"; do unset -f "$_cmd"; done
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  unset _nvm_commands _cmd
}
for _cmd in "${_nvm_commands[@]}"; do
  eval "${_cmd}() { _nvm_load; ${_cmd} \"\$@\"; }"
done
unset _cmd

# ── goenv (if installed) — alternative to Homebrew-managed Go ─────────────────
# uncomment if you switch Go versions regularly
# export GOENV_ROOT="$HOME/.goenv"
# export PATH="$GOENV_ROOT/bin:$PATH"
# eval "$(goenv init -)"

# ── fzf ───────────────────────────────────────────────────────────────────────
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
# use fd for fzf file finding (respects .gitignore, faster than find)
if command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
[[ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]] && \
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
[[ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ]] && \
  source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

# ── ripgrep ───────────────────────────────────────────────────────────────────
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

# ── bat ───────────────────────────────────────────────────────────────────────
export BAT_THEME="base16"

# ── Docker ────────────────────────────────────────────────────────────────────
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# ── CDPATH — jump to project roots without full paths ────────────────────────
export CDPATH=".:$HOME:$HOME/code:$HOME/projects"
