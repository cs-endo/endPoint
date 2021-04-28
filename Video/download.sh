#!/bin/bash

function youtube480 {
	method='youtube-dl \
-o "%(title)s" -i \
-f "bestvideo[height<=480]+bestaudio/best[height<=480]" '

        [[ -n $1 ]] && $method $@ || echo "$method"
}

function youtube480GT {
	method='youtube-dl \
-o "%(playlist_index)s-%(title)s.%(ext)s" -i \
-f "bestvideo[height<=480]+bestaudio/best[height<=480]" '

	[[ -n $1 ]] && $method $@ || echo "$method"
}
