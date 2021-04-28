#!/bin/bash
set -u

# ------ Export file location
export endPoint=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

# ------ Alias script files
alias ad="$endPoint/Misc/command_repeater.sh"
alias refresh="source $HOME/.bash_profile"

# ------ Source script files
# -- Don't source a file with "set" rules
source "$endPoint/Misc/alias_utils.sh"
source "$endPoint/Misc/crun.sh"
source "$endPoint/Video/download.sh"
