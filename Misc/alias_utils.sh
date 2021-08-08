#!/bin/bash

# ---------------------------------
# Terminal
function refresh { source $HOME/.bash_profile; }
function la { ls -lah; }
function ra { ranger; }

function cmkdir {
	[[ -n $1 ]] || return
	mkdir $1; cd $1
}

function quiet {
	[[ -n $1 ]] || return
	$@ &> /dev/null &
	disown
}

function unique {
	# $1 = some filename
	# Not by best but it does what it's supposed to
	tac "$1" | cat -n | sed -e 's/^ *//g' | sort -u -k 2 | sort -r -g | cut -f 2-
}

function link_config {
	# $1 = 'x' to enable x file linking
	# $1 = 's' to enable vim and ranger config
	cd $HOME
	for conf in "$endPoint/_CONFIG/home/".*; do
		# Ignore folders - TODO enable folders to work well
		[[ -d "$conf" ]] && { echo "Skipping $conf"; continue; }
		# Ignore .x files unless explicit
		[[ "$conf" == *"/home/.x"* && "$1" != "x" ]] \
			&& { echo "Skipping $conf"; continue; }
		# Link files
		ln -s "$conf" && echo "ln: successfully linked $conf"
	done

	# Temporary fix
	if [[ "$1" == "s" ]]; then
	  ln -s "$endPoint/_CONFIG/home/.config/vimrc" \
	    ".config/vimrc" && echo "ln: successfully linked vim config"
	  ln -s "$endPoint/_CONFIG/home/.config/ranger/rc.conf" \
	    ".config/ranger/rc.conf" && echo "ln: successfully linked ranger config"
	fi

	cd -
}

function regit {
        cd "$endPoint/.."
        git clone https://github.com/cs-499243/endPoint.git
        refresh
        cd -
}


alias ad="$endPoint/Misc/command_repeater.sh"
alias ads="$endPoint/Misc/command_scheduler.sh"

# ---------------------------------
# Utilities
function gits { git status; }
function gitd { git diff; }
function gitdc { git diff --cached; }
function gitc {
	# $1 = message (put between "")
	git commit -m "$1"
}

function archive {
	# $1 = archive title
	# TODO Make this auto set to the date
	7z a -p -mhe=on $1 *
}

function sortSSH {
	# If a key needs a password, echo manual command
	eval "$(ssh-agent -s)"
	grep "IdentityFile" "$HOME/.ssh/config" | cut -d'~' -f2 | while read line
	  do ssh-add "$HOME$line" || echo " FAILED - ssh-add \"$HOME$line\""
	done
}

# ---------------------------------
# System

# Kept as aliases - will likely not be repeated
alias begin="startx"
alias end="shutdown now"

function monitor {
        xrandr --output VGA1 --off
	sleep 1
        if [[ -n $(xrandr | grep "VGA1 connected") ]]; then
                xrandr --output VGA1 --auto --right-of LVDS1; ~/.fehbg
        fi
}

function get_power {
	echo $( printf %02d $(cat /sys/class/power_supply/BAT0/capacity) )
}

# ---------------------------------
# Misc
function weather { curl wttr.in?format=v2; }
function stocks { curl rate.sx/$1; }

# ---------------------------------
# Music
function pul { pulsemixer; }

function mp {
        if [[ -z $(ps ch -C mpd) ]]; then
                mpd &> /dev/null
                mpc update
        fi
        if [[ -n $1 ]]; then
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
