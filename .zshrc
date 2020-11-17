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

# Custom path with extra locations.
#   - Add ~/Library/Python/3.8/bin for stuff installed via `pip install --user`.
#   - Add Homebrew and Homebrew installed Python 3.8 to path to override OS Python on macOS.
export PATH="$HOME/Library/Python/3.8/bin:/usr/local/opt/python@3.8/libexec/bin:/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH"

# Enable plugins.
plugins=(git brew history kubectl)

# Turn on shell autocomplete.
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
# Python                                                                      #
###############################################################################

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
 
# commands to override pip restriction above.
# use `gpip` or `gpip3` to force installation of
# a package in the global python environment
# Never do this! It is just an escape hatch.
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# Add pyenv to use Python versions that aren't in Homebrew.
eval "$(pyenv init -)"

# Always create pipenv virtualenvs in project.
export PIPENV_VENV_IN_PROJECT=1

###############################################################################
# Vagrant / Packer                                                            #
###############################################################################

# Make Vagrant use Vmware by default.
export VAGRANT_DEFAULT_PROVIDER=vmware_desktop

# Put all Vagrant VMs in one directory for easy exclusion from Time Machine.
export VAGRANT_VMWARE_CLONE_DIRECTORY=$HOME/.vagrantvms 

# Move Packer cache dir out of individual project directories for easy exclusion from Time Machine.
export PACKER_CACHE_DIR=$HOME/.packer_cache

###############################################################################
# ZSH Functions                                                               #
###############################################################################

# Delete a given line number in the known_hosts file.
knownrm() {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    echo "error: line number missing" >&2;
  else
    sed -i '' "$1d" ~/.ssh/known_hosts
  fi
}

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
## AWS                                                                       ##
###############################################################################

# Set default AWS profile.
export AWS_PROFILE=pan-lab

awslogin() {
  aws sso login --profile=$AWS_PROFILE
}

# Get creds as environment variables.
awscreds() {
    eval "$(aws2-wrap --export)"
}

# List AWS instances.
awsls () { 
  aws ec2 describe-instances --query "Reservations[*].Instances[*].[Tags[?Key=='Name'] | [0].Value,Tags[?Key=='Environment'] | [0].Value,PublicIpAddress,InstanceId,InstanceType,State.Name]" --output table
}

# Get an AWS instance by name.
awsinstancename() {
  aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" $2 --query 'Reservations[].Instances[].InstanceId' --output text
}

# Get all AWS instances tagged with a specific Environment tag.
awsenv() {
  aws ec2 describe-instances --filters "Name=tag:Environment,Values=$1" $2 --query 'Reservations[].Instances[].InstanceId' --output text
}

# Start an AWS instance by name.
awsstart () {
  aws ec2 start-instances --instance-ids `awsinstancename $1 "Name=instance-state-name,Values=stopping,stopped"`
}

# Stop an AWS instance by name.
awsstop () {
  aws ec2 stop-instances --instance-ids `awsinstancename $1 "Name=instance-state-name,Values=pending,running"`
}
