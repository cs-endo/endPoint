#!/bin/bash

function youtube480 {
        [[ -n $1 ]] && youtube-dl \
-o "%(title)s" -i \
-f "bestvideo[height<=480]+bestaudio/best[height<=480]" $1;
}

function youtube480GT {
	[[ -n $1 ]] && youtube-dl \
-o "%(playlist_index)s-%(title)s.%(ext)s" -i \
-f "bestvideo[height<=480]+bestaudio/best[height<=480]" $@
}
