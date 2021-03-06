colReset=$(tput sgr0);

colMain=$(tput setaf 10);
colAlert=$(tput setaf 196);
colWarn=$(tput setaf 202);
colSafe=$(tput setaf 014);
colGray=$(tput setaf 250);
colWhi=$(tput setaf 15);

function get_branch {
	git branch &> /dev/null || return
	branch=$(git branch | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')

	col=$colSafe
	[[ -z $(git diff --cached --name-only) ]] || col=$colWarn
	[[ -z $(git diff --name-only) ]] || col=$colAlert

	echo ${branch:+":${col}$branch${colReset}"}
}

PS1="\[${colWhi}\]\n╔═══[ \[${colMain}\]\u@\h\[${colGray}\]:\[${SHELL}\]\$(get_branch)"
PS1+="\[${colWhi}\]\n║ \[${colGray}\]\t [\w]";
PS1+="\[${colWhi}\]\n╚═══[ \[${colReset}\]";
export PS1;

export EDITOR=vim

export LESSHISTFILE=/dev/null
export HISTFILE="$HOME/.temp/bash_history"
export VIMINIT="source $HOME/.config/vimrc"

source $HOME/.config_local

source $(dirname -- "$(readlink -f -- "$BASH_SOURCE")")/../../hook.sh
