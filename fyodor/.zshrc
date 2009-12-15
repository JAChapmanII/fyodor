# Lines configured by zsh-newuser-install
HISTFILE=~/.history_zsh
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch
unsetopt notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/fyodor/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

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

typeset -gU path

setopt short_loops complete_in_word interactive_comments brace_ccl dvorak hash_list_all 
setopt auto_pushd chase_dots pushd_ignore_dups pushd_silent
setopt hist_ignore_dups hist_ignore_space hist_verify hist_reduce_blanks extended_history
source ~/.zsh/prompt.zsh
source ~/.zsh/keys.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/style.zsh
