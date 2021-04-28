#!/bin/bash
set -Eeuo pipefail

[[ -z "$@" ]] && adCommand="touch" || adCommand="$@"
echo "Running command [$adCommand]"

while :; do
	read -p ' - ' adInput

	[[ -z "$adInput" ]] && break

	$adCommand "$adInput" || echo "Invalid Command"
done
