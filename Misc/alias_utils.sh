#!/bin/bash

alias ad="$endPoint/Misc/command_repeater.sh"
alias ads="$endPoint/Misc/command_scheduler.sh"
alias begin="startx"
alias end="shutdown now"
alias gita="git add *"
alias gits="git status"
alias gitd="git diff"
alias gitdc="git diff --cached"
alias gitp="git push origin master"
alias gitget="git pull origin master"
alias la="ls -lah"
alias lat="ls -lahrt"
alias lc="ls -1"
alias lynxc="$endpoint/Network/lynxc.sh"
alias price_btc="curl rate.sx/btc"
alias price_eth="curl rate.sx/eth"
alias price_xmr="curl rate.sx/xmr"
alias pul="pulsemixer"
alias ra="ranger"
alias refresh="source $HOME/.bash_profile"
alias update="sudo pacman -Syyu"
alias weather="curl wttr.in?format=v2"

function cmkdir {
	[[ -n $1 ]] || return
	mkdir "$1"; cd "$1"
}

function quiet {
	[[ -n $1 ]] || return
	$@ &> /dev/null &
	disown
}

function gitc { git commit -m "$1"; }
function gitca { git commit --amend -m "$1"; }

##################################
### HACKS
##################################

function archive {
	# $1 = archive title
	7z a -p -mhe=on "$1" *
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

function sortSSH {
	# If a key needs a password, echo manual command
	eval "$(ssh-agent -s)"
	grep "IdentityFile" "$HOME/.ssh/config" | cut -d'~' -f2 | while read line
	  do ssh-add "$HOME$line" || echo " FAILED - ssh-add \"$HOME$line\""
	done
}

function autolatex {
	file="${1%.*}"
	mkdir TeXoutput; pdflatex -halt-on-error -output-directory=TeXoutput "$file.tex"
	zathura "TeXoutput/$file.pdf" &
 	echo "$file.tex" | entr pdflatex -halt-on-error -output-directory=TeXoutput "$file.tex"
}

function gpp {
	while :; do
		ls | entr -d -s "clear; g++ -o .out.o $(ls -rt | tail -n 1) && ./.out.o"
	done
}

function monitor {
	xrandr --output VGA1 --off
	[[ -n $1 ]] && return # Give any argument, to turn off monitor

	sleep 1

	if [[ -n $(xrandr | grep "VGA1 connected") ]]; then
		xrandr --output VGA1 --auto --right-of LVDS1; ~/.fehbg
    fi
}

function get_power {
	echo $( printf %02d $(cat /sys/class/power_supply/BAT0/capacity) )
}

function mp {
		mount_state=$(find ${music_dir:-"$HOME/Music"} -xtype l)
		[[ -n $mount_state ]] && { echo "Error - Music not fully mounted"; return 1; }

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

