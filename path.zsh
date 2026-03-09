# path.zsh
# Sourced via zprofile — login shells only.
# Runs AFTER /etc/zprofile which calls macOS path_helper.
# PATH manipulation here wins because we run last in the login shell sequence.

# Idempotency guard — prevents double-loading if this file is sourced twice
[[ -n "$_PATH_LOADED" ]] && return
export _PATH_LOADED=1

# -- Homebrew — must come first, everything else depends on it ----------------
# Placed here (not zshenv) because macOS path_helper runs between zshenv and
# zprofile, which would reorder and undo any PATH changes made in zshenv.
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# -- User bin — single location for all user-installed binaries ---------------
export PATH="$HOME/.local/bin:$PATH"

# -- Static tool paths --------------------------------------------------------
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.minikube/bin:$PATH"

# -- Go -----------------------------------------------------------------------
export GOBIN="$HOME/.local/bin"
# If you switch Go versions often, use goenv instead of Homebrew-managed Go:
#   export GOENV_ROOT="$HOME/.goenv"
#   export PATH="$GOENV_ROOT/bin:$PATH"
#   eval "$(goenv init -)"

# -- Language toolchain homes — direct everything to ~/.local -----------------
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export NPM_CONFIG_PREFIX="$HOME/.local"
export PIPX_HOME="$HOME/.local/share/pipx"

# -- Compiler flags -----------------------------------------------------------
# Merged openssl + tcl-tk — only needed at compile time, login-once is fine
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib -L/opt/homebrew/opt/tcl-tk/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include -I/opt/homebrew/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig:/opt/homebrew/opt/tcl-tk/lib/pkgconfig"

# Python compile opts for tcl-tk (used by pyenv when building Python)
export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes=-I/opt/homebrew/opt/tcl-tk/include --with-tcltk-libs=-L/opt/homebrew/opt/tcl-tk/lib"

# -- KUBECONFIG ---------------------------------------------------------------
export KUBECONFIG="$HOME/.kube/config"
# For multiple clusters:
# export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/work-config"

# -- SDKMAN — slow init, login-only is appropriate ----------------------------
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# JAVA_HOME — set explicitly for tools that bypass the PATH shim (mvn, gradle)
export JAVA_HOME="$(sdk home java current 2>/dev/null)"

# -- Networking / TLS ---------------------------------------------------------
# Uncomment if behind a corporate proxy or using custom CAs
# export HTTP_PROXY=""
# export HTTPS_PROXY=""
# export NO_PROXY="localhost,127.0.0.1,.internal"
# export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
# export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"

