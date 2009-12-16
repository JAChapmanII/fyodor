# use the "most" pager if it's available
if [[ -x $(which most) ]]; then
    export PAGER=most
else
    export PAGER=less
fi

# return to w3m when not in X
if [ $DISPLAY ]; then
    export BROWSER="arora"
else
    export BROWSER="lynx"
fi

# more of the same, for editors
if [[ -x $(which vim) ]]; then
    export EDITOR="vim"
else
    export EDITOR="vi"
fi

for dir in \
	/home/fyodor/bin
do
	[ -d "${dir}" ] && PATH="${dir}:${PATH}"
done


# Arch now puts its manpages in here
if [ -d "/usr/share/man" ]; then
    MANPATH="/usr/share/man/:$MANPATH"
fi

# I like a narrow manpage
export MANWIDTH=80

# finally, remove duplicates from paths
typeset -gU path manpath

export XDG_CONFIG_HOME=/home/fyodor/.config

# options
setopt extended_glob
setopt short_loops
setopt complete_in_word
setopt interactive_comments
setopt brace_ccl 
setopt dvorak 
setopt hash_list_all 
setopt beep 
setopt nomatch
unsetopt notify

# directory stuff
setopt auto_pushd
setopt auto_cd
setopt chase_dots
setopt pushd_ignore_dups
setopt pushd_silent

# history stuff
# I'd love for this to be ten times as big, but this causes history
# searching to slow right down when it can't find anything.
HISTSIZE=10240
SAVEHIST=1048576
HISTFILE=$XDG_CONFIG_HOME/history_zsh
setopt appendhistory
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks
setopt extended_history
unsetopt hist_no_functions	# double negative?

autoload -Uz compinit; compinit
autoload colors; colors

CONFDIR="$XDG_CONFIG_HOME/zsh"
set -A files \
    "$CONFDIR/aliases.zsh" "$CONFDIR/functions.zsh" \
    "$CONFDIR/style.zsh" "$CONFDIR/keys.zsh" "$CONFDIR/prompt.zsh"

function src()
{
    autoload -U zrecompile
    if [ -f "$XDG_CONFIG_HOME/zsh/zshrc" ]; then
		zrecompile -p "$XDG_DATA_HOME/zsh/zshrc"
	fi
    for f in $files; do
		[ -f $f ] && zrecompile -p $f
    done
}

for f in $files
do
    if [ -f $f ]; then
		source $f
	else
		print "$bg[red]$fg[white]Error:$terminfo[sgr0] $f is unavailable."
    fi
done
