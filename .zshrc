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

###############################################################################
# ZSH Auto-Completion                                                         #
###############################################################################

# Load auto-completions from brew site-functions directory.
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

###############################################################################
# zsh tools: oh-my-posh, zoxide, direnv                                       #
###############################################################################

eval "$(oh-my-posh init zsh --config $HOME/.dotfiles/ohmyposh/zen.json)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

###############################################################################
# Aliases                                                                     #
###############################################################################

alias ls="ls -GF"

alias unssh="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias unscp="scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

alias commit-types="cat ~/.dotfiles/commit-types"
alias ct="cat ~/.dotfiles/commit-types"

###############################################################################
# direnv                                                                      #
###############################################################################

# Use direnv to load per directory environment variables.


###############################################################################
# 1Password                                                                   #
###############################################################################

# Use 1Password SSH agent.
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
