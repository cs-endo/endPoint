#!/bin/bash
# If .bash_profile is not from endpoint, add the following to it
#  source "[endPoint's directory]/hook.sh"

# ------ Export file location
export endPoint=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

# ------ Source script files
# -- Don't source a file with "set" rules
source "$endPoint/Misc/alias_utils.sh"
source "$endPoint/Misc/crun.sh"
source "$endPoint/Video/ytdl.sh"
