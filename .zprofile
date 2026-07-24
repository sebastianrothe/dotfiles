# Homebrew environment.
eval "$(/opt/homebrew/bin/brew shellenv)"

# JetBrains Toolbox command-line launchers.
[[ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]] &&
  path+=("$HOME/Library/Application Support/JetBrains/Toolbox/scripts")
  