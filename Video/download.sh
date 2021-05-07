#!/bin/bash

function youtube {
	method="youtube-dl -i \
-o %(title)s "

	[[ -n $1 ]] && $method $@ || echo "$method"
}

function youtube720 {
        method="youtube-dl -i \
-o %(title)s \
-f best[height<=?720]+bestaudio/best "

        [[ -n $1 ]] && $method $@ || echo "$method"
}

function youtube480 {
	method="youtube-dl -i \
-o %(title)s \
-f best[height<=?480]+bestaudio/best "

        [[ -n $1 ]] && $method $@ || echo "$method"
}

function youtube480GT {
	method="youtube-dl -i \
-o %(playlist_index)s-%(title)s.%(ext)s \
-f best[height<=?480]+bestaudio/best "

	[[ -n $1 ]] && $method $@ || echo "$method"
}
