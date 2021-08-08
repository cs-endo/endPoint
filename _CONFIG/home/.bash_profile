textReset=$(tput sgr0);
colCyan=$(tput setaf 14);

colGray=$(tput setaf 250);
colWhi=$(tput setaf 15);

PS1="\[${colWhi}\]\n╔═══[ \[${colCyan}\]\u@\h - \[${HOME}\]";
PS1+="\[${colWhi}\]\n║ \[${colGray}\]\t - \[${PPID}\]:\j - \[${SHELL}\]";
PS1+="\[${colWhi}\]\n║ \[${colGray}\]\w";
PS1+="\[${colWhi}\]\n╚═══[ \[${colGray}\]";
export PS1;

export LESSHISTFILE=/dev/null
export HISTFILE="$HOME/.temp/bash_history"
export VIMINIT="source $HOME/.config/vimrc"

source "$HOME/.bashrc"
