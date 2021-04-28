#!/bin/bash
set -Eeuo pipefail; shopt -s expand_aliases

[[ -z "$@" ]] && adCommand="touch" || adCommand="$@"
echo "Running command [$adCommand]"

while :; do
	read -p ' - ' adInput

	[[ -z "$adInput" ]] && break

	$adCommand "$adInput" || echo "Invalid Command"
done
