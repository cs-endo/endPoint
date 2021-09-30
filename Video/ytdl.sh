#!/bin/bash

function ytdlConf {
	argAV="$1"	# $1: [a/v/V][###] - e.g. v480 for 480p video
	argFName="$2"	# $2: p=index, t=title, u=date, x=ext
	shift 2		# $@: additional parameters + URL

	declare -A dictOutFormat=( \
["v"]="--merge-output-format mp4" \
["V"]="--merge-output-format mp4 --postprocessor-args '-s hd360 -crf 24 -strict -2 -c:v libx264 -c:a aac'" \
["a"]="-x --audio-format mp3" )

	declare -A dictFileName=( \
["q"]="/tmp/video.mp4"
["tx"]="%(title)s.%(ext)s" \
["ptx"]="%(playlist_index)3d-%(title)s.%(ext)s" \
["utx"]="%(upload_date)s_%(title)s.%(ext)s" )


	# If resolution is given, specify the download to be of that resolution
	avType="${argAV::1}"	# e.g. v480 --> v
	avRes="${argAV:1}"	# e.g. v480 --> 480
	[[ -z $avRes ]] || avInpFormat="-f best[height=$avRes]+bestaudio/best"

	# If no URL given, print the command otherwise executed
	#  -i		Ignore errors (useful for imperfect playlists)
	#  --http-...	Workaround for issue with speed dropping to 50kb
	baseCom="youtube-dl -i --http-chunk-size 15M"

	# Unfortunately, this is needed so both forms work AND have the same filenames
	if [[ -z $1 ]]; then
	  echo $baseCom $avInpFormat ${dictOutFormat[$avType]} -o \"${dictFileName[$argFName]}\" $@
	else
	  $baseCom $avInpFormat ${dictOutFormat[$avType]} -o ${dictFileName[$argFName]} $@
	fi
}

function youtube	{ ytdlConf v tx $@; }
function youtubeTMP	{ ytdlConf v360 q $@; }
function youtube480	{ ytdlConf v480 tx $@; }
function youtube480GT   { ytdlConf v720 ptx $@; }
function youtube720	{ ytdlConf v720 tx $@; }
function youtubeA	{ ytdlConf a tx $@; }
function youtubeAGT	{ ytdlConf a ptx $@; }

function twitch		{ ytdlConf v360 utx $@ || ytdlConf V utx $@; }
