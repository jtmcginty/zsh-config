# completion.zsh
# Tab completion setup. Must run after plugins.zsh and tools.zsh (pyenv must be initialized first).

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
# git
if command -v git &>/dev/null; then
  zstyle ':completion:*:*:git:*' script "$(brew --prefix)/share/zsh/site-functions/_git" 2>/dev/null
fi

# gh (GitHub CLI)
if command -v gh &>/dev/null; then
  source <(gh completion -s zsh)
fi

# kubectl
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

# helm
if command -v helm &>/dev/null; then
  source <(helm completion zsh)
fi

# minikube
if command -v minikube &>/dev/null; then
  source <(minikube completion zsh)
fi

# kustomize
if command -v kustomize &>/dev/null; then
  source <(kustomize completion zsh)
fi

# stern (multi-pod log tailing)
if command -v stern &>/dev/null; then
  source <(stern --completion zsh)
fi

# flux (FluxCD)
if command -v flux &>/dev/null; then
  source <(flux completion zsh)
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

# vault
if command -v vault &>/dev/null; then
  autoload -Uz bashcompinit && bashcompinit 2>/dev/null
  complete -o nospace -C vault vault
fi

# aws
if command -v aws_completer &>/dev/null; then
  autoload -Uz bashcompinit && bashcompinit 2>/dev/null
  complete -C aws_completer aws
fi

# poetry
if command -v poetry &>/dev/null; then
  source <(poetry completions zsh 2>/dev/null | grep -v '^\s*_poetry.*"\$@"')
fi

# step (smallstep CLI — certs, OIDC, SSH)
if command -v step &>/dev/null; then
  source <(step completion zsh)
fi

# ── Disabled — uncomment when actively using ──────────────────────────────────
# argocd
# if command -v argocd &>/dev/null; then source <(argocd completion zsh); fi

# skaffold
# if command -v skaffold &>/dev/null; then source <(skaffold completion zsh); fi

# kind
# if command -v kind &>/dev/null; then source <(kind completion zsh); fi

# eksctl
# if command -v eksctl &>/dev/null; then source <(eksctl completion zsh); fi

# velero
# if command -v velero &>/dev/null; then source <(velero completion zsh); fi

# consul
# if command -v consul &>/dev/null; then complete -o nospace -C consul consul; fi

# nomad
# if command -v nomad &>/dev/null; then complete -o nospace -C nomad nomad; fi

# packer
# if command -v packer &>/dev/null; then complete -o nospace -C packer packer; fi

# boundary
# if command -v boundary &>/dev/null; then complete -o nospace -C boundary boundary; fi

# istioctl
# if command -v istioctl &>/dev/null; then source <(istioctl completion zsh); fi

# linkerd
# if command -v linkerd &>/dev/null; then source <(linkerd completion zsh); fi

# doctl (DigitalOcean)
# if command -v doctl &>/dev/null; then source <(doctl completion zsh); fi

# pulumi
# if command -v pulumi &>/dev/null; then source <(pulumi gen-completion zsh); fi
