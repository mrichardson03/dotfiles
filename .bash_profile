#
# .bash_profile
# Ripped off a lot from gerlingguy/dotfiles
#
# @author Michael Richardson
#

# Nicer prompt.
export PS1="\[\e[0;32m\]\]\[\] \[\e[1;32m\]\]\t \[\e[0;2m\]\]\w \[\e[0m\]\]\[$\] "

# Use colors.
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

alias ls='ls -GF'

# Custom $PATH with extra locations.
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH

export VAGRANT_DEFAULT_PROVIDER=vmware_desktop

export GOPATH=$HOME/Projects/go

# Include bashrc file (if present).
if [ -f ~/.bashrc ]
then
  source ~/.bashrc
fi

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

alias unssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias unscp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

# Git aliases.
alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gsd='git svn dcommit'
alias gsfr='git svn fetch && git svn rebase'

# Git upstream branch syncer.
# Usage: gsync master (checks out master, pull upstream, push origin).
function gsync() {
  if [[ ! "$1" ]] ; then
      echo "You must supply a branch."
      return 0
  fi

  BRANCHES=$(git branch --list $1)
  if [ ! "$BRANCHES" ] ; then
     echo "Branch $1 does not exist."
     return 0
  fi

  git checkout "$1" && \
  git pull upstream "$1" && \
  git push origin "$1"
}

# Turn on Git autocomplete.
brew_prefix=`brew --prefix`
if [ -f $brew_prefix/etc/bash_completion ]; then
  . $brew_prefix/etc/bash_completion
fi

# Delete a given line number in the known_hosts file.
knownrm() {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    echo "error: line number missing" >&2;
  else
    sed -i '' "$1d" ~/.ssh/known_hosts
  fi
}

# Python setup from Brian Torres-Gil: https://medium.com/@briantorresgil/definitive-guide-to-python-on-mac-osx-65acd8d969d0

# activate virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# create commands to override pip restriction.
# use `gpip` or `gpip3` to force installation of
# a package in the global python environment
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

awsls () { 
  aws ec2 describe-instances --query "Reservations[*].Instances[*].[Tags[?Key=='Name'] | [0].Value,Tags[?Key=='Environment'] | [0].Value,PublicIpAddress,InstanceType,State.Name]" --output table
}

awstagquery() {
  aws ec2 describe-instances --filters "Name=tag:Environment,Values=$1" $2 --query 'Reservations[].Instances[].InstanceId' --output text
}

awsstart () {
  aws ec2 start-instances --instance-ids `awstagquery $1 "Name=instance-state-name,Values=stopping,stopped"`
}

awsstop () {
  aws ec2 stop-instances --instance-ids `awstagquery $1 "Name=instance-state-name,Values=pending,running"`
}

md2word () {
  PANDOC_INSTALLED=$(pandoc --version >> /dev/null; echo $?)

  if [ "0" == ${PANDOC_INSTALLED} ]; then
    pandoc -o $2 -t docx -f markdown $1
  else
    echo "Pandoc is not installed.  Unable to convert document."
  fi
}