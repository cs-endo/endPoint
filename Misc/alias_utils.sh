#!/bin/bash

# ---------------------------------
# Terminal
alias refresh="source $HOME/.bash_profile"
alias la="ls -lah"

function clean {
	[[ -n $1 ]] || return
	$@ &> /dev/null &
	disown
}

# ---------------------------------
# Utilities
alias got="git status"
alias gut="git diff"
alias gitd="git diff --cached"

# ---------------------------------
# System
alias begin="startx"
alias end="shutdown now"

function monitor {
        xrandr --output VGA1 --off
        if [[ -n $(xrandr | grep "VGA1 connected") ]]; then
                xrandr --output VGA1 --auto --right-of LVDS1; ~/.fehbg
        fi
}

# ---------------------------------
# Misc
alias weather="curl wttr.in?format=v2; read"

# ---------------------------------
# Music
alias pul="pulsemixer"

function mp {
        if [[ -z $(ps ch -C mpd) ]]; then
                mpd &> /dev/null
                mpc update
        fi
        if [[ $1 -eq 1 ]]; then
                mpd --kill &> /dev/null
                return
        fi
        ncmpcpp --quiet
}

# ---------------------------------





# ---------------------------------
# ARCHIVE

# function autolatex {
#	mkdir TeXoutput; pdflatex -halt-on-error -output-directory=TeXoutput "$1.tex"
#	zathura "TeXoutput/$1.pdf" &
# 	echo "$1.tex" | entr pdflatex -halt-on-error -output-directory=TeXoutput "$1.tex"
#}

# function wifi {
#	echo "Changing wifi state - will need to confirm sudo"
#	[[ $1 -eq 1 ]] && wifiOp="up" || wifiOp="down"
#	sudo ifconfig wlp3so $wifiOp && echo "WiFi: $wifiOp"
#}

# function signal_strength {
# 	echo -n "Signal Strength Monitor - Type time: "; read tLength
#	echo
#	while :; do
#	echo -n -e "\e[1A"
#
#	iwconfig wlan0 | grep Signal | cut -d' ' -f14-
#	sleep $tLength; done
#}

# ---------------------------------
