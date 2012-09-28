#!/bin/echo Warnning, this library must only be sourced!
# vim: set expandtab smarttab shiftwidth=4 tabstop=4:

#
# Author: tuantuan.lv <dangoakachan@foxmail.com>
# Status: Development
# Description: defines functions for printing log messages.
#

# {{ Global constants definition

# Log level constants
LOG_ERROR=0       # Level error
LOG_WARNING=1     # Level warning
LOG_INFO=2        # Level info
LOG_DEBUG=3       # Level debug

# Log level names
LOG_LEVELNAMES=('ERROR' 'WARNING' 'INFO' 'DEBUG')

# Global constants definition end }}

# Show log whose level less than this
log_level=3
# Default date fmt
date_fmt='%Y-%m-%d %H:%M:%S'
# Default log fmt
log_fmt="[<levelname>] [<asctime>] <message>"
# Default log color
log_color=('red' 'yellow' 'blue' '')
# Support colors
support_colors='red yellow blue white cyan gray purple green'

# {{ LOG functions start

# Print log messages
# $1: Log level
# $2: C style printf fmt
# $3: C style printf arguments
function do_log()
{
    local level=$1
    local msg="$2"
    local fmt="${log_fmt}"

    if [ $level -gt $log_level ]; then
        return
    fi

    fmt="${fmt//<levelname>/${LOG_LEVELNAMES[$level]}}"
    fmt="${fmt//<asctime>/$(date +"$date_fmt")}"
    fmt="${fmt//<message>/$msg}"

    shift && ${log_color[level]:-printf} "$fmt" "$@"
}

function debug_msg()
{
    local fmt=$1
    shift && do_log $LOG_DEBUG "$fmt" "$@"
}

function info_msg()
{
    local fmt=$1
    shift && do_log $LOG_INFO "$fmt" "$@"
}

function warn_msg()
{
    local fmt=$1
    shift && do_log $LOG_WARNING "$fmt" "$@"
}

function error_msg()
{
    local fmt=$1
    shift && do_log $LOG_ERROR "$fmt" "$@"
    return 1
}

function exit_msg()
{
    error_msg "$@"
    exit 1
}

# LOG functions end }}

# Colorful print start {{

function red()
{
    printf "\033[1;31m${1}\033[0m" "$@"
}

function green()
{
    printf "\033[1;32m${1}\033[0m" "$@"
}

function gray()
{
    printf "\033[1;37m${1}\033[0m" "$@"
}

function yellow()
{
    printf "\033[1;33m${1}\033[0m" "$@"
}

function blue()
{
    printf "\033[1;34m${1}\033[0m" "$@"
}

function cyan()
{
    printf "\033[1;36m${1}\033[0m" "$@"
}

function purple()
{
    printf "\033[1;35m${1}\033[0m" "$@"
}

function white()
{
    printf "\033[1;38m${1}\033[0m" "$@"
}

# Colorful print end }}

# {{ Log set functions 

# Set default log level
function set_loglevel()
{
    if echo "$1" | grep -qE "^[0-9]+$"; then
        log_level="$1"
    fi
}

# Set log format
function set_logfmt()
{
    if [ -n "$1" ]; then
        log_fmt="$1"
    fi
}

# Set date format, see 'man date'
function set_datefmt()
{
    if [ -n "$1" ]; then
        date_fmt="$1"
    fi
}

# Set log colors
function set_logcolor()
{
    local len=$#

    for (( i=0; i<$len; i++ )); do
        if echo "$support_colors" | grep -wq "$1"
        then
            log_color[$i]=$1
        else
            log_color[$i]=''
        fi

        shift
    done
}

# Disable colorful log
function disable_color()
{
    set_logcolor '' '' '' ''
}

# Log set functions }}
