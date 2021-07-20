#!/bin/bash

function ytdlConf {
	argAV="$1"	# $1: [a/v/V][###] - e.g. v480 for 480p video
	argFname="$2"	# $2: p=index, t=title, u=date, x=ext
	shift 2		# $@: additional parameters + URL

	declare -A dictOutFormat=( \
["v"]="--merge-output-format mp4" \
["V"]="--merge-output-format mp4 --postprocessor-args '-s hd360 -crf 24 -strict -2 -c:v libx264 -c:a aac'" \
["a"]="-x --audio-format mp3" )

	declare -A dictFileName=( \
["tx"]="-o '%(title)s.%(ext)s'" \
["ptx"]="-o '%(playlist_index)3d-%(title)s.%(ext)s'" \
["utx"]="-o '%(upload_date)s_%(title)s.%(ext)s'" )


	# If resolution is given, specify the download to be of that resolution
	avType="${argAV::1}"	# e.g. v480 --> v
	avRes="${argAV:1}"	# e.g. v480 --> 480
	[[ -z $avRes ]] || avInpFormat="-f best[height=$avRes]+bestaudio/best"

	# If no URL given, print the command otherwise executed
	baseCom="youtube-dl -i"
	[[ -z $1 ]] && baseCom="echo $baseCom"
	$baseCom $avInpFormat ${dictOutFormat[$avType]} ${dictFileName[$argFName]} $@
}

function youtube	{ ytdlConf v tx $@; }
function youtube480	{ ytdlConf v480 tx $@; }
function youtube480GT   { ytdlConf v720 ptx $@; }
function youtube720	{ ytdlConf v720 tx $@; }
function youtubeA	{ ytdlConf a tx $@; }

function twitch		{ ytdlConf v360 utx $@ || ytdlConf V utx $@; }
