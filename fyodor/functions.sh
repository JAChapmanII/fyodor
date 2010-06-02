#!/bin/bash
txtblk='\033[0;30m' # Black - Regular {{{
txtred='\033[0;31m' # Red
txtgrn='\033[0;32m' # Green
txtylw='\033[0;33m' # Yellow
txtblu='\033[0;34m' # Blue
txtpur='\033[0;35m' # Purple
txtcyn='\033[0;36m' # Cyan
txtwht='\033[0;37m' # White
bldblk='\033[1;30m' # Black - Bold
bldred='\033[1;31m' # Red
bldgrn='\033[1;32m' # Green
bldylw='\033[1;33m' # Yellow
bldblu='\033[1;34m' # Blue
bldpur='\033[1;35m' # Purple
bldcyn='\033[1;36m' # Cyan
bldwht='\033[1;37m' # White
unkblk='\033[4;30m' # Black - Underline
undred='\033[4;31m' # Red
undgrn='\033[4;32m' # Green
undylw='\033[4;33m' # Yellow
undblu='\033[4;34m' # Blue
undpur='\033[4;35m' # Purple
undcyn='\033[4;36m' # Cyan
undwht='\033[4;37m' # White
bakblk='\033[40m'   # Black - Background
bakred='\033[41m'   # Red
badgrn='\033[42m'   # Green
bakylw='\033[43m'   # Yellow
bakblu='\033[44m'   # Blue
bakpur='\033[45m'   # Purple
bakcyn='\033[46m'   # Cyan
bakwht='\033[47m'   # White
txtrst='\033[0m'    # Text Reset }}}

function require_root()
{
	# Error on non-root user
	if [ "$UID" -ne "0" ]
	then
		print_error "You are not root"
		exit 1
	fi
}

function update_time ()
{
	ctime="$(date +'%d|%H:%M:%S')"
	timestamp="[$ctime]"
}

function print_message ()
{
	update_time
	echo -e "${txtgrn}${timestamp}${txtrst} $*"
}

function print_warn ()
{
	update_time
	echo -e "${txtblu}${timestamp}${txtrst} $*"
}

function print_error ()
{
	update_time
	echo -e "${txtred}${timestamp}${txtrst} $*"
}

function print_note ()
{
	update_time
	echo -e "${txtcyn}${timestamp}${txtrst} $*"
}

# Create a directory for the current day
function now ()
{
    mkdir -p `date +%F`
    cd `date +%F`
}

