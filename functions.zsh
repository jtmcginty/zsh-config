# functions.zsh
# Functions use _name internally to avoid alias conflicts.
# Aliases in aliases.zsh point to these so they show up in `alias` output.

# ── _search — fuzzy search file contents with live reload ────────────────────
_search() {
  fzf --ansi --disabled \
    --bind "change:reload:rg --files-with-matches --ignore-case {q} . || true" \
    --bind "enter:execute(nvim {})" \
    --preview "
      if [[ {} == *.html ]] || [[ {} == *.htm ]]; then
        lynx -dump -width=\$FZF_PREVIEW_COLUMNS -nolist {} 2>/dev/null || \
          bat --color=always --style=numbers --line-range=:500 {}
      else
        bat --color=always --style=numbers --line-range=:500 {}
      fi"
}

# ── _gi — generate .gitignore via gitignore.io ────────────────────────────────
# usage: gi python,node,macos
_gi() {
  curl -sLw "\n" "https://www.toptal.com/developers/gitignore/api/$*"
}

# ── mkcd — make a directory and cd into it ───────────────────────────────────
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ── port — find what's listening on a port ───────────────────────────────────
port() {
  lsof -i ":${1:?usage: port <number>}"
}

# ── epoch — convert epoch timestamp to human-readable, or print current epoch
epoch() {
  if [[ -n "$1" ]]; then
    date -r "$1"
  else
    date +%s
  fi
}
