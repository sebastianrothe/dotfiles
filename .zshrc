#
# ~/.zshrc
# Plain zsh, based partly on Jeff Geerling's minimalist configuration.
#

#
# PATH
#

# Preserve order while removing duplicates.
typeset -U path PATH

path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /usr/local/bin
  /usr/local/sbin
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOME/.composer/vendor/bin"
  "$HOME/.cargo/bin"
  "$HOME/Library/Python/3.12/bin"
  $path
)

#
# Environment
#

unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

# Unmatched globs remain literal instead of raising an error.
unsetopt nomatch

export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'
export HOMEBREW_AUTO_UPDATE_SECS=604800
export COMPOSER_MEMORY_LIMIT=-1

#
# Prompt
#

PS1=$'\n''%F{green} %*%f %3~'$'\n''$ '

#
# Local configuration
#

[[ -r "$HOME/.aliases" ]] && source "$HOME/.aliases"

#
# Completion
#

autoload -Uz compinit

zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|=*' \
  'l:|=* r:|=*'

compinit

#
# Runtime management
#

# mise manages Node, Java, and other language runtimes.
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

#
# Interactive tools
#

# fzf provides Ctrl-T and Alt-C.
# Disable its Ctrl-R binding because Atuin owns history search.
if (( $+commands[fzf] )); then
  FZF_CTRL_R_COMMAND= source <(fzf --zsh)
fi

# zoxide must come after compinit for completion support.
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# Inline suggestions.
if [[ -r "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Atuin owns Ctrl-R but leaves Up/Down as normal history navigation.
if (( $+commands[atuin] )); then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

#
# Zellij
#

# Manual use only; no additional mux layer for every shell.
if (( $+commands[zellij] )); then
  alias zj='zellij attach main --create'
  alias zjp='zellij attach "$(basename "$PWD")" --create'
fi

#
# Git aliases
#

alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

#
# File and directory aliases
#

alias tree='tree -a -I .git'

alias ls='ls -A'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias lsa='ls -lah'

alias df='df -h'
alias du='du -h'
alias rd='rmdir'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias dotfiles='git -C "$HOME/Documents/projects/dotfiles"'

if (( $+commands[trash] )); then
  alias rm='trash -F'
fi

#
# Functions adapted from Geerling's configuration
#

gsync() {
  if (( $# != 1 )); then
    print -u2 'Usage: gsync <branch>'
    return 2
  fi

  local branch=$1

  if ! git show-ref --verify --quiet "refs/heads/$branch"; then
    print -u2 "Local branch does not exist: $branch"
    return 1
  fi

  git switch "$branch" &&
    git pull upstream "$branch" &&
    git push origin "$branch"
}

dockrun() {
  local image="geerlingguy/docker-${1:-ubuntu1604}-ansible"
  docker run --rm -it "$image" /bin/bash
}

denter() {
  if (( $# != 1 )); then
    print -u2 'Usage: denter <container>'
    return 2
  fi

  docker exec -it "$1" bash
}

knownrm() {
  if [[ $1 != <-> ]]; then
    print -u2 'Usage: knownrm <line-number>'
    return 2
  fi

  sed -i '' "${1}d" "$HOME/.ssh/known_hosts"
}
