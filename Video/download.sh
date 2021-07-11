#!/bin/bash

function twitch {
	# For whatever reason this acts differently in interactive mode
	mOut="%(upload_date)s_%(title)s.%(ext)s"

	downLow="best[height<=360]+bestaudio/best"
	downHigh="--postprocessor-args \
'-s hd360 -crf 24 -strict -2 -c:v libx264 -c:a aac'"

	mBase="youtube-dl -i --merge-output-format mp4"

	if [[ -n $1 ]]; then
	  # If 360p download fails, get full hd and use ffmpeg postproc.
	  $mBase -o $mOut -f $downLow $@ || $mBase -o $mOut $downHigh $@
	else
	  # Not ideal but makes sure the output CAN be run
	  echo "$mBase -o "'"'"$mOut"'"'" -f '$downLow'"
	fi
}

function youtube {
	method="youtube-dl -i \
-o %(title)s.%(ext)s \
--merge-output-format mp4 "

	[[ -n $1 ]] && $method $@ || echo "$method"
}

function youtube720 {
        method="youtube-dl -i \
-o %(title)s.%(ext)s \
-f best[height<=?720]+bestaudio/best \
--merge-output-format mp4 "

        [[ -n $1 ]] && $method $@ || echo "$method"
}

function youtube480 {
	method="youtube-dl -i \
-o %(title)s.%(ext)s \
-f best[height<=?480]+bestaudio/best \
--merge-output-format mp4 "

        [[ -n $1 ]] && $method $@ || echo "$method"
}

function youtube480GT {
	method="youtube-dl -i \
-o %(playlist_index)3d-%(title)s.%(ext)s \
-f best[height<=?480]+bestaudio/best \
--merge-output-format mp4 "

	[[ -n $1 ]] && $method $@ || echo "$method"
}

function youtubeA {
	method="youtube-dl -i \
-o "'"'"%(title)s.%(ext)s"'"'" \
-x --audio-format mp3 "

	[[ -n $1 ]] && $method $@ || echo "$method"
}
