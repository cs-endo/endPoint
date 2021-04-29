#!/bin/bash

function youtube {
	method='youtube-dl -i \
-o "%(title)s" '

	[[ -n $1 ]] && $method $@ || echo "$method"
}

function youtube480 {
	method='youtube-dl -i \
-o "%(title)s" \
-f "bestvideo[height<=480]+bestaudio/best[height<=480]" '

        [[ -n $1 ]] && $method $@ || echo "$method"
}

function youtube480GT {
	method='youtube-dl -i \
-o "%(playlist_index)s-%(title)s.%(ext)s" \
-f "bestvideo[height<=480]+bestaudio/best[height<=480]" '

	[[ -n $1 ]] && $method $@ || echo "$method"
}
