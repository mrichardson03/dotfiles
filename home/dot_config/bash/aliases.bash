#!/usr/bin/env bash
# Bash aliases

#######################################################################
# Ls Variants                                                         #
#######################################################################

# Use eza if installed.
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -al --header --icons --group-directories-first'
else
  alias ls='ls -aF'
  alias ll='ls -laF'
fi

#######################################################################
# System Info                                                         #
#######################################################################

alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'

alias myip="hostname -I | awk '{print \$1}' && echo -n 'External: ' && curl -4s ifconfig.me && echo"

########################################################################
# Utilities                                                            #
########################################################################

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
