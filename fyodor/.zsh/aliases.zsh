#!/bin/zsh

# cope aliases
for cope in acpi arp cc df dprofpp fdisk free g++ gcc id ifconfig ls lspci \
	lsusb make md5sum mpc netstat nm nmap nocope ping pmap ps readelf route \
	screen sha1sum sha224sum sha256sum sha384sum sha512sum shasum socklist \
	stat strace tcpdump tracepath traceroute w wget who xrandr
do
	eval "alias $cope='cope $cope'"
done

alias mkdir='mkdir -p'
alias dt="date +'%y:%m:%d:%H:%M:%S:%N'"
alias nocope='export PATH=`echo $PATH | sed "s-/usr/share/perl5/vendor_perl/auto/share/dist/Cope:--g"`'
alias precope='export PATH=`echo "/usr/share/perl5/vender_perl/auto/share/dist/Cope:$PATH"`'
alias noccache='export PATH=`echo $PATH | sed "s-/usr/lib/ccache/bin:--g"`'
alias preccache='export PATH=`echo "/usr/lib/ccache/bin:$PATH"`'
#alias makepkg='export PATH=`sed "s_/usr/share/perl5/vendor_perl/auto/share/dist/Cope:__g" $PATH`; makepkg'

# other things with other arguments
alias grep="egrep --color=auto"
alias v="vim"
alias vi="vim"
alias df="cope df -h"

# misc
alias e="$EDITOR"

#alias ls='ls -a --color'
alias ls="ls -hF --color"	# defaults
alias ll="ls -lh"		# list long
alias la="ls -a"		# list all
alias lz="ls -tr"		# list by date
alias lsa="ls -ld .*"		# list only dotfiles
alias lsd="ls -d -- *(/)"       # list only dirs
alias lsdirs="ls -d -- *(-/DN)"	# list only dirs and links
alias lsdots="ls -a -- .*(.)"   # list only dotfiles
alias lsx="ls -- *(*)"          # list only executables
alias lssuid="ls -l -- *(s,S)" 	# list only suid
alias lz="ls -tr"		# list by date
alias lsnew="ls -rtl"           # list by date>
alias lsold="ls -tl"            # list by date<
alias lssmall="ls -Sl"          # list by size>
alias lsbig="ls -Slr"           # list by size<
alias l="ls"
