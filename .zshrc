#
# .zshrc
# Ripped off a lot from gerlingguy/dotfiles
#
#

# Pull in local shell config if it's present.
if [[ -f $HOME/.zshrc.local ]]; then
  source $HOME/.zshrc.local
fi

# Enable colors on the cli.
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

# Nice looking prompt.
export PS1="%F{green} %*%F{blue} %3~ %F{white}$ "

###############################################################################
# Path                                                                        #
###############################################################################
export PATH="$HOME/bin:$PATH"

###############################################################################
# Homebrew                                                                    #
###############################################################################

ARCH=$(/usr/bin/arch)
if [[ $ARCH == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi


################################################################################
# ZSH Auto-Completion                                                          #
################################################################################

# Load auto-completions from brew site-functions directory.
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

###############################################################################
# Aliases                                                                     #
###############################################################################

alias ls="ls -GF"

alias unssh="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias unscp="scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

alias commit-types="cat ~/.dotfiles/commit-types"
alias ct="cat ~/.dotfiles/commit-types"

###############################################################################
# ZSH Functions                                                               #
###############################################################################

# Remove all host keys for a given IP address.
knownrm() {
  re='^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    echo "error: ip address missing" >&2;
  else
    sed -i '' -e "/$1/d" ~/.ssh/known_hosts
  fi
}

# Pulled from https://about.gitlab.com/blog/2020/01/30/simple-trick-for-smaller-screenshots/
function pngshrink() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a filename."
    return 0
  fi

  pngquant 64 --skip-if-larger --strip --ext=.png --force "$1"
  zopflipng -y "$1" "$1"
}

###############################################################################
# direnv                                                                      #
###############################################################################

# Use direnv to load per directory environment variables.
eval "$(direnv hook zsh)"

###############################################################################
# 1Password                                                                   #
###############################################################################

# Use 1Password SSH agent.
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
