#!/bin/zsh
# functions < zsh

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

# Create a directory for the current day
function now ()
{
    mkdir -p `date +%F`
    cd `date +%F`
}

