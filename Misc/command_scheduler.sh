#!/bin/bash

# Set environment for script to run - "set -u" causes issues
shopt -s expand_aliases
set -Eeo pipefail

# Find endPoint folder and enable aliases
selfPwd=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
source "$selfPwd/../hook.sh"

# If no arguments given, use "touch"
method=${@:-"touch"}
echo "Running command [$method]"

comFile="$HOME/command_scheduler.sh.data"
echo "" > $comFile

while :; do
	read -p ' - ' arguments

	[[ -z "$arguments" ]] && break

	echo -e "$method \"$arguments\" " >> $comFile
done

bash $comFile
