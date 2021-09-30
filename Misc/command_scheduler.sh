#!/bin/bash

comFile="$HOME/command_scheduler.sh.$(date +%s)"

# selfPwd = Location $endPoint is stored in
# comPwd = Location command_scheduler.sh is run from
# basePwd = Location the generated script is run from
selfPwd=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
comPwd=$(pwd)

# TODO Combine all file writes into 1 - maybe store in buffer variable
echo '# This is a generated bash file using command_scheduler...' > "$comFile"
echo 'shopt -s expand_aliases; set -Eeo pipefail' >> "$comFile"
echo "source \"$selfPwd/../hook.sh\" " >> "$comFile"
echo 'basePwd=$(pwd)' >> "$comFile"
echo "cd \"$comPwd\" " >> "$comFile"

# If no arguments given, use "touch"
method=${@:-"touch"}
echo "Running command [$method]"

while :; do
	read -p ' - ' arguments

	[[ -z "$arguments" ]] && break

	echo -e "$method \"$arguments\" " >> "$comFile"
done

echo 'cd "$basePwd"' >> "$comFile"

bash "$comFile" && rm "$comFile"
