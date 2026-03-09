# secrets.zsh
# Sources all files in ~/.secrets — loaded last so secrets can reference
# anything set earlier in the session.
#
# IMPORTANT:
#   chmod 700 ~/.secrets
#   Add ~/.secrets to your dotfiles .gitignore — never commit this directory
#
# Recommended layout:
#   ~/.secrets/
#     postgres.sh      # POSTGRESQL_PASSWORD etc
#     tokens.sh        # API keys, personal access tokens
#     work.sh          # work-specific env vars

if [[ -d "$HOME/.secrets" ]]; then
  for _secret_file in "$HOME"/.secrets/[^.]*; do
    [[ -f "$_secret_file" ]] && source "$_secret_file"
  done
  unset _secret_file
fi
