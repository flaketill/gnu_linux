#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias python="/usr/bin/python2"
alias up="sudo pacman -Syu"
alias ls='ls --color=auto'
alias instalar="sudo packer -S --noconfirm --noedit"
PS1='[\u@\h \W]\$ '

source ~/git-completion.bash

extract() 
{
	if [ -f $1 ] ; then
	case $1 in
	*.tar.bz2) tar xvjf $1 ;;
	*.tar.gz) tar xvzf $1 ;;
	*.bz2) bunzip2 $1 ;;
	*.rar) rar x $1 ;;
	*.gz) gunzip $1 ;;
	*.tar) tar xvf $1 ;;
	*.tbz2) tar xvjf $1 ;;
	*.tgz) tar xvzf $1 ;;
	*.zip) unzip $1 ;;
	*.Z) uncompress $1 ;;
	*.7z) 7z x $1 ;;
	*) echo "i dont know how to extract $1"  ;;
	esac
	else
	echo "$1 is not a valid file!"
	fi
}

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
