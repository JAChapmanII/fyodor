#!/bin/zsh
# prompt < zsh

# no more zshscript!

function shell_prompt_precmd() {
    PROMPT="%{$terminfo[enacs]%}
"
    PROMPT+=`perl ~/.zsh/prompt.pl`
    PROMPT+="%{$terminfo[sgr0]%}"
}

precmd_functions+=(shell_prompt_precmd)

# Protect against stupid dumb terminals trying to do anything that's
# not too clever for them or whatever

if [ $TERM = "dumb" ]; then
    unsetopt zle
    PS1='$ '
fi
