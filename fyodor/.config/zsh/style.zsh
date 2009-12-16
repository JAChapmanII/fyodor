#!/bin/zsh
# style < zsh

zmodload -i zsh/complist

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true

# general colouring in (yellow for status, red for warnings)
zstyle ':completion:*' format $'%{\e[0;33m%}completing %B%d%b%{\e[0m%}'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format $'%{\e[1;41m%}No matches for:%{\e[0m%} %d'
zstyle ":completion:*:descriptions" format $'%{\e[0;33m%}%d:%{\e[0m%}'
zstyle ":completion:*:corrections" format $'%{\e[0;31m%}%d (errors: %e)%}'

# colouring in for specific items
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*:local-directories" list-colors '=*=1;34'
zstyle ":completion:*:hosts" list-colors '=*=1;33'
zstyle ":completion:*:users" list-colors '=*=1;31'
zstyle ":completion:*:functions" list-colors '=*=34'
zstyle ":completion:*:aliases" list-colors '=*=1;34'
zstyle ":completion:*:commands" list-colors '=*=1;32'
zstyle ":completion:*:builtins" list-colors '=*=32'
zstyle ":completion:*:parameters" list-colors '=*=1;33'

# separate them out into groups
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''

# allow case-insensitivity, amongst other things
zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'

# man pages organised into sections
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# a pretty kill menu
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:processes' command 'ps -U $(whoami) | sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select

# ignore backup files
zstyle ":completion:*:complete:-command-::commands" ignored-patterns '*\~'

# ignore zsh's own completion functions when completing
zstyle ':completion:*:functions' ignored-patterns '_*'

# be approximate
zstyle ':completion:::::' completer _complete _prefix _correct _approximate
zstyle ':completion:*:approximate:*' max-errors 1

# only ask before displaying completions if it would scroll
LISTMAX=0

# colourised ls completion
# now with more colours!

LS_COLORS='';
LS_COLORS=$LS_COLORS:'no=00'           # normal text
LS_COLORS=$LS_COLORS:'fi=00'	       # regular file
ls_COLORS=$LS_COLORS:'di=01;34'	       # directory
LS_COLORS=$LS_COLORS:'ex=01;32'	       # executable file
LS_COLORS=$LS_COLORS:'ln=01;36'	       # symlink
LS_COLORS=$LS_COLORS:'or=40;31'	       # orphaned link
LS_COLORS=$LS_COLORS:'pi=40;33'	       # named pipe
LS_COLORS=$LS_COLORS:'so=01;35'	       # socket
LS_COLORS=$LS_COLORS:'bd=33;01'	       # block device
LS_COLORS=$LS_COLORS:'cd=33;01'	       # character device
LS_COLORS=$LS_COLORS:'*.tar=1;31'      # archives = red
LS_COLORS=$LS_COLORS:'*.tgz=1;31'      # "
LS_COLORS=$LS_COLORS:'*.gz=1;31'       # "
LS_COLORS=$LS_COLORS:'*.zip=1;31'      # "
LS_COLORS=$LS_COLORS:'*.sit=1;31'      # "
LS_COLORS=$LS_COLORS:'*.lha=1;31'      # "
LS_COLORS=$LS_COLORS:'*.lzh=1;31'      # "
LS_COLORS=$LS_COLORS:'*.arj=1;31'      # "
LS_COLORS=$LS_COLORS:'*.bz2=1;31'      # "
LS_COLORS=$LS_COLORS:'*.7z=1;31'       # "
LS_COLORS=$LS_COLORS:'*.Z=1;31'	       # "
LS_COLORS=$LS_COLORS:'*.rar=1;31'      # "
LS_COLORS=$LS_COLORS:'*.bak=1;30'      # boring files = grey
LS_COLORS=$LS_COLORS:'*.swp=1;30'      # " (vim swapfiles)
LS_COLORS=$LS_COLORS:'*~=1;30'         # " (vim/emacs backups)
LS_COLORS=$LS_COLORS:'*#=1;30'         # " (emacs files)
LS_COLORS=$LS_COLORS:'*.o=1;30'        # " (object files)
LS_COLORS=$LS_COLORS:'*.a=1;30'        # " (shared libs)
LS_COLORS=$LS_COLORS:'*.zwc=1;30'      # " (zsh wordcode)
LS_COLORS=$LS_COLORS:'*.zwc.old=1;30'  # " (zsh wordcode backups)
LS_COLORS=$LS_COLORS:'*.pyc=1;30'      # " (python compiled)
LS_COLORS=$LS_COLORS:'*.class=1;30'    # " (java classes)
LS_COLORS=$LS_COLORS:'*.jpg=1;35'      # medias = other colour
LS_COLORS=$LS_COLORS:'*.jpeg=1;35'     # " (images)
LS_COLORS=$LS_COLORS:'*.png=1;35'      # "
LS_COLORS=$LS_COLORS:'*.gif=1;35'      # "
LS_COLORS=$LS_COLORS:'*.bmp=1;35'      # "
LS_COLORS=$LS_COLORS:'*.ppm=1;35'      # "
LS_COLORS=$LS_COLORS:'*.pgm=1;35'      # "
LS_COLORS=$LS_COLORS:'*.pbm=1;35'      # "
LS_COLORS=$LS_COLORS:'*.tiff=1;35'     # "
LS_COLORS=$LS_COLORS:'*.PNG=1;35'      # "
LS_COLORS=$LS_COLORS:'*.xpm=1;35'      # "
LS_COLORS=$LS_COLORS:'*.mp3=1;35'      # " (sounds)
LS_COLORS=$LS_COLORS:'*.ogg=1;35'      # "
LS_COLORS=$LS_COLORS:'*.wav=1;35'      # "
LS_COLORS=$LS_COLORS:'*.m4a=1;35'      # "
LS_COLORS=$LS_COLORS:'*.flac=1;35'     # "
LS_COLORS=$LS_COLORS:'*.mpeg=1;35'     # " (media)
LS_COLORS=$LS_COLORS:'*.mpg=1;35'      # "
LS_COLORS=$LS_COLORS:'*.avi=1;35'      # "
LS_COLORS=$LS_COLORS:'*.flv=1;35'      # "
LS_COLORS=$LS_COLORS:'*.wmv=1;35'      # "
LS_COLORS=$LS_COLORS:'*.ogv=1;35'      # "
LS_COLORS=$LS_COLORS:'*.mov=1;35'      # "
LS_COLORS=$LS_COLORS:'*README=4;1;33'  # important files = orange, underline
LS_COLORS=$LS_COLORS:'*INSTALL=4;1;33' # "
LS_COLORS=$LS_COLORS:'*FAQ=4;1;33'     # "
LS_COLORS=$LS_COLORS:'*.pls=4;1;35'	# "
LS_COLORS=$LS_COLORS:'*Makefile=4;1;33'	# "
LS_COLORS=$LS_COLORS:'*Rakefile=4;1;33'	# "
LS_COLORS=$LS_COLORS:'*PKGBUILD=4;1;33'	# "
LS_COLORS=$LS_COLORS:'*SConstruct=4;1;33'	# "
LS_COLORS=$LS_COLORS:'*Install.hs=4;1;33'	# "
LS_COLORS=$LS_COLORS:'*Install.lhs=4;1;33'	# "
LS_COLORS=$LS_COLORS:'*extconf.rb=4;1;33'	# "
LS_COLORS=$LS_COLORS:'*Makefile.PL=4;1;33'	# "
LS_COLORS=$LS_COLORS:'*Build.PL=4;1;33'	# "
LS_COLORS=$LS_COLORS:'*.torrent=4;1;33'	# anything else?
export LS_COLORS

export GREP_COLOR="1;33"
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

