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

while :; do
	read -p ' - ' arguments

	$method "$arguments" || echo "Command failed"
done
