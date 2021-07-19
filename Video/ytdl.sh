#!/bin/bash

function ytdlConf {
	argOut="$1"	# a V v v360 v480 v720...
	argFile="$2"	# p=index, t=title, u=date, x=ext
			# $@ = additional parameters + URL
	shift 2

	declare -A outputs=( \
["v"]="--merge-output-format mp4" \
["V"]="--merge-output-format mp4 --postprocessor-args '-s hd360 -crf 24 -strict -2 -c:v libx264 -c:a aac'" \
["a"]="-x --audio-format mp3" )

	declare -A name_forms=( \
["tx"]="-o '%(title)s.%(ext)s'" \
["ptx"]="-o '%(playlist_index)3d-%(title)s.%(ext)s'" \
["utx"]="-o '%(upload_date)s_%(title)s.%(ext)s'" )


	outType="${argOut::1}"
	outRes="${argOut:1}"
	[[ -z $outRes ]] || outRes="-f best[height=$outRes]+bestaudio/best"

	[[ -z $1 ]] && base="echo youtube-dl -i" || base="youtube-dl -i"
	$base ${outputs[$outType]} ${name_forms[$argFile]} $outRes $@
}

function youtube { 	ytdlConf v tx $@; }
function youtube480 {	ytdlConf v480 tx $@; }
function youtube720 {	ytdlConf v720 tx $@; }
function youtube480GT {	ytdlConf v720 ptx $@; }
function youtubeA {	ytdlConf a tx $@; }

function twitch { 	ytdlConf v360 utx $@ || ytdlConf V utx $@; }
