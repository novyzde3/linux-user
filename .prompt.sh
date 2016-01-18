#!/bin/bash

S=$?

END="\[\e[0m\]"
RED="\[\e[31;1m\]"
CYAN="\[\e[36;1m\]"
GREEN="\[\e[32;1m\]"
YELLOW="\[\e[33;1m\]"

if [[ $S -eq 0 ]]; then
        DOLLAR="${YELLOW}\$"
else
        DOLLAR="${RED}\$"
fi

# For GIT
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto verbose"
# Pridat do PS1: $(__git_ps1 " [%s]")

PS1="${CYAN}\u${END}@${RED}\h${END} ${GREEN}${PWD##*/}/$(__git_ps1 " [%s]")${END} ${DOLLAR}${END} "

