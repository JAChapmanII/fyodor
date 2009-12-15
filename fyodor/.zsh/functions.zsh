#!/bin/zsh
# functions < zsh

# rot13()
function rot13 () {              # For some reason, rot13 pops up everywhere
    if [ $# -eq 0 ]; then
        tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    else
        echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    fi
}
 
# isprime() -- Is $1 prime?
#function isprime () { 
#	perl -wle 'print "Prime" if (1 x shift) !~ /^1?$|^(11+?)\1+$/'
#}

# make a commit to the current git repo
function gitc () { git commit -a -m "$*" }

function sendtext() {
	number="$1"; shift; message="$*"

  # try stdin
  [ -z "$message" ] && message="$(cat /dev/stdin)"

  if [ -n "${number//[0-9]/}" ]; then
    echo "not sending; invalid number $number"
    return 1
  fi

  if [ -z "$message" ]; then
    echo "not sending; no message to send"
    return 1
  fi

  if [ $(wc -c <<< "$message") -gt 160 ]; then
    echo "not sending; message greater than 160 characters"
    return 1
  fi

  echo $message | mail "$number@vtext.com"
}

# mkdir and cd
function mcd() {    # mind-control device
    test -z "$1" && echo "mcd: no path given" && return
    test -d "$1" && print "mcd: directory $1 already exists"
    mkdir -p -- "$1"
    cd -- "$1"
}

# calculator
function calc () { echo $* | bc -l }
alias calc="noglob calc"

# Convert stuff between bases
typeset -A bases
bases[bin]=2; 
bases[oct]=8; 
bases[dec]=10; 
bases[hex]=16
for base in {bin,oct,hex}; do
    eval "function dec${base} { echo 10i $bases[$base]o \$1:u p | dc }"
    eval "function ${base}dec { echo 10o $bases[$base]i \$1:u p | dc }"
done

# Convert hex #rrggbb to decimal
function hexrgb () {
    local rgb=`hexdec $1`
    echo "($rgb / 65536)" | bc
    echo "($rgb / 256) % 256" | bc
    echo "$rgb % 256" | bc
}

# Fix a dir
function fix ()
{
    if [ -d $1 ]; then
	chmod 755 $1/**/*(/)
	chmod 644 $1/**/*(.)
    else
	echo "$1 is not a directory."
    fi
}


# Look stuff up in a dictionary
function dict () { perl ~/bin/dict $* }

# Show newest files
function newest ()
{
    local many=`first-numeric $argv 1`
    echo *(om[1,$many])
}

# Show newest directories
function newdirs ()
{
    local many=`first-numeric $argv 1`
    echo *(/om[1,$many])
}

# Start a new Perl module
function perlmodule () {
    module-starter --module=$1 --mi --author="Benjamin Sago aka \`cytzol\`" --email="ben at cytzol dot org" --verbose
}

# Extract stuff from any archive
function extract () {
    if [ -f $1 ]; then
	case $1 in
	    *.tar.bz2)	tar -xjvf $1  ;;
	    *.tbz2)     tar -xjvf $1  ;;
	    *.bz2)  	bzip2 -d $1   ;;
	    *.tar.gz)	tar -xzvf $1  ;;
	    *.tgz)	tar -xzvf $1  ;;	    
	    *.gz)   	gunzip -d $1  ;;
	    *.tar)  	tar -xvf $1   ;;
	    *.zip)	unzip $1      ;;
	    *.Z)	uncompress $1 ;;
	    *.rar)	unrar x $1    ;;
	    *.7z)       7z x $1       ;;
	    *) echo "'$1' is no archive" ;;
	esac
    else
	echo "'$1' is not a valid file"
    fi
}

# Look inside any archive
function lsarchive ()
{
    if [ -f $1 ]; then
	case $1 in
	    *.tar.bz2)	tar -jtf $1 ;;
	    *.tar.gz)	tar -ztf $1 ;;
	    *.tar)	tar -tf $1  ;;
	    *.tgz)	tar -ztf $1 ;;
	    *.zip)	unzip -1 $1 ;;
	    *.rar)	rar vb $1   ;;
	    *.7z)       7z l $1     ;;
	    *)		echo "'$1' is no archive" ;;
	esac
    else
	echo "'$1' is not a valid archive"
    fi
}

compctl -g '*.tar.Z *.tar.gz *.tgz *.zip *.ZIP *.tar.bz2 *.rar' + -g '*' show-archive extract
compctl -g '*.pkg.tar.gz' + -g '*' pacman -U
compctl -g '*.pkg.tar.gz' + -g '*' sudo pacman -U

# Uptime penis
function dick () { uptime | perl -ne "/(\d+) d/;print 8,q(=)x\$1,\"D\n\"" }

# Create a directory for the current day
function now ()
{
    mkdir -p `date +%F`
    cd `date +%F`
}

# google? yep.
function google ()
{
	$BROWSER "http://google.com/search?q=$1"
}

# Subway's subs of the day
function sotd ()
{
    if [[ $1 == "" ]]; then
	sotd `date +%A`
    else
	case $1 in
	    Monday)    echo "Monday: Turkey and Ham" ;;
	    Tuesday)   echo "Tuesday: Meatballs" ;;
	    Wednesday) echo "Wednesday: Turkey" ;;
	    Thursday)  echo "Thursday: Italian BMT" ;;
	    Friday)    echo "Friday: Tuna" ;;
	    Saturday)  echo "Saturday: Ham" ;;
	    Sunday)    echo "Sunday: Spicy Italian" ;;
	    *) echo "wtf?" ;;
	esac
    fi
}

# Run a command and display the result with notify
function go ()
{
    $@
    local error=$?
    if [[ $error -eq 0 ]]; then
	notify-send "$1 Complete" -t 3000 "$1 $2"
    else
	notify-send "$1 Failed" -t 3000 "$1 $2" -u critical
    fi
    return $error
}

# Search my MSN logs
#PURPLELOGDIR="$HOME/.purple/logs/msn/ben@cytzol.com"
#function chatlogrep ()
#{
#    old=`pwd`
#    cd $PURPLELOGDIR/$1/
#    grep $2 *
#    cd $old
#}

#function logdirs { reply=(`ls $PURPLELOGDIR/`) }
#compctl -K logdirs chatlogrep

# Change the MAC address of an interface.
function machange ()
{
    if [[ $# == 0 ]]; then
	echo "Usage: $0 interface address"
    else
	sudo ifconfig $1 hw ether $2
    fi
}

compdef _net_interfaces machange

# set up SSH keys
#function keychainify ()
#{
#    /usr/bin/keychain -Q -q ~/.ssh/id_dsa
#    [[ -f $HOME/.keychain/hostname-sh ]] && source $HOME/.keychain/$HOSTNAME-sh
#}

# view an xbm file as ascii
function xbm ()
{
    perl -MImage::Xbm -e "print Image::Xbm->new(-file, shift)->as_string" $1
}

# Helper functions

function first-numeric ()
{
    for i in $argv; do
	if [[ $i == <-> ]]; then
	    print $i; break
	fi
    done
}

function first-non-numeric ()
{
    for i in $argv; do
	if [[ $i != <-> ]]; then
	    print $i; break
	fi
    done
}

