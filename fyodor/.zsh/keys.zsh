#!/bin/zsh
# keys < zsh

#bindkey -e		# emacs keybindings please
bindkey -v	# we want vim ;)

# key bindings

bindkey ' '		magic-space

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix	# tab

# Paste into the terminal: middle-click is hard to click.

function xpaste ()
{
    LBUFFER+=`xclip -o`
}

zle -N xpaste
bindkey "^X^X" xpaste

# Make directories while writing something else.

function zle-mkdir ()
{
    if [[ $RBUFFER == "" ]]; then
	zle -M "What?"
    elif [ -d $RBUFFER ]; then
	zle -M "Dir exists"
    elif [ -f $RBUFFER ]; then
	zle -M "File exists"
    else
	mkdir $RBUFFER
    fi
}

zle -N zle-mkdir
bindkey "^X^M" zle-mkdir

# Be clever about dots.

function rationalise-dot ()
{
    if [[ $LBUFFER = *.. ]]; then
	LBUFFER+=/..
    else
	LBUFFER+=.
    fi
}

zle -N rationalise-dot
bindkey . rationalise-dot
