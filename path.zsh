# path.zsh
# Sourced via zprofile — login shells only. Runs once when your session starts.
# PATH manipulation, Homebrew init, compiler flags, SDKMAN, JAVA_HOME.

# ── Homebrew — must come first so brew bins win over system ──────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"

# ── User bin — single location for all user-installed binaries ───────────────
export PATH="$HOME/.local/bin:$PATH"

# ── Compiler flags ────────────────────────────────────────────────────────────
# Merged openssl + tcl-tk — order matters, don't split these across files
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib -L/opt/homebrew/opt/tcl-tk/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include -I/opt/homebrew/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig:/opt/homebrew/opt/tcl-tk/lib/pkgconfig"

# Python compile opts for tcl-tk (used by pyenv when building Python)
export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes=-I/opt/homebrew/opt/tcl-tk/include --with-tcltk-libs=-L/opt/homebrew/opt/tcl-tk/lib"

# ── Static tool paths ─────────────────────────────────────────────────────────
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.minikube/bin:$PATH"

# ── Go ────────────────────────────────────────────────────────────────────────
# Using Homebrew-managed Go (gvm dropped — poorly maintained)
# If you switch Go versions often, consider goenv:
#   export GOENV_ROOT="$HOME/.goenv"
#   export PATH="$GOENV_ROOT/bin:$PATH"
#   eval "$(goenv init -)"
export GOBIN="$HOME/.local/bin"

# ── Language toolchain homes — direct everything to ~/.local ─────────────────
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export NPM_CONFIG_PREFIX="$HOME/.local"
export PIPX_HOME="$HOME/.local/share/pipx"

# ── KUBECONFIG — colon-separated supports multiple context files ──────────────
export KUBECONFIG="$HOME/.kube/config"
# For multiple clusters:
# export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/work-config"

# ── SDKMAN — slow init, login-only is appropriate ────────────────────────────
# Handles Java, Kotlin, Gradle, Maven — replaces jenv
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# JAVA_HOME — set explicitly for tools that don't use the PATH shim (mvn, gradle)
export JAVA_HOME="$(sdk home java current 2>/dev/null)"

# ── Networking / TLS ──────────────────────────────────────────────────────────
# Uncomment if behind a corporate proxy or using custom CAs
# export HTTP_PROXY=""
# export HTTPS_PROXY=""
# export NO_PROXY="localhost,127.0.0.1,.internal"
# export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
# export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
