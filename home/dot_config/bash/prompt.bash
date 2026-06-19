#!/usr/bin/env bash
# Prompt configuration

# Color definitions
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
YELLOW="\[\e[1;33m\]"
BLUE="\[\e[1;34m\]"
MAGENTA="\[\e[1;35m\]"
CYAN="\[\e[1;36m\]"
WHITE="\[\e[1;37m\]"
GRAY="\[\e[1;90m\]"
ENDC="\[\e[0m\]"

# Simple prompt, including distrobox container if applicable.
export PS1="${GREEN}${CONTAINER_ID:-$HOSTNAME}${ENDC}:\W\$ "
