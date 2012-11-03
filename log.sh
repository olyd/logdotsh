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

# Support colors
SUPPORT_COLORS='red yellow blue white cyan gray purple green'

# Default log file
if [ ! -f "$0" ]; then
    _log_file="/tmp/logdotsh.log.`date +'%Y%m%d'`"
else
    base=$(basename $0 | awk -F. '{print $1}')
    _log_file="/tmp/$base.log.`date +'%Y%m%d'`"
    unset base
fi

# Show log whose level less than this
_log_level=3
# Default date fmt
_date_fmt='%Y-%m-%d %H:%M:%S'
# Default log fmt
_log_fmt="[<levelname>] [<asctime>] <message>"
# Default log color
_log_color=('red' 'yellow' 'green' '')

# Global constants definition end }}

# {{ LOG functions start

# Print log messages
# $1: Log level
# $2: C style printf fmt
# $3: C style printf arguments
function do_log()
{
    local level=$1
    local msg="$2"
    local fmt="${_log_fmt}"

    # Set log format
    fmt="${fmt//<asctime>/$(date +"$_date_fmt")}"
    fmt="${fmt//<message>/$msg}"
    fmt="${fmt//<levelname>/${LOG_LEVELNAMES[$level]}}"

    shift 2

    # Print all log messages to log file
    printf "$fmt" "$@" >> $_log_file

    if [ $level -le $_log_level ]; then
        ${_log_color[level]:-printf} "$fmt" "$@"
    fi
}

# Print log message to both file and stdout
# Use log_msg if you want to print log message always, and don't 
# want to be controlled by set_loglevel
function log_msg()
{
    local msg="$1"
    local fmt="${_log_fmt}"

    # Set log format
    fmt="${fmt//<asctime>/$(date +"$_date_fmt")}"
    fmt="${fmt//<message>/$msg}"
    fmt="${fmt//<levelname>/LOG}"

    shift && printf "$fmt" "$@" | tee -a $_log_file
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
    local fmt=$1
    shift && printf "\033[1;31m${fmt}\033[0m" "$@"
}

function green()
{
    local fmt=$1
    shift && printf "\033[1;32m${fmt}\033[0m" "$@"
}

function gray()
{
    local fmt=$1
    shift && printf "\033[1;37m${fmt}\033[0m" "$@"
}

function yellow()
{
    local fmt=$1
    shift && printf "\033[1;33m${fmt}\033[0m" "$@"
}

function blue()
{
    local fmt=$1
    shift && printf "\033[1;34m${fmt}\033[0m" "$@"
}

function cyan()
{
    local fmt=$1
    shift && printf "\033[1;36m${fmt}\033[0m" "$@"
}

function purple()
{
    local fmt=$1
    shift && printf "\033[1;35m${fmt}\033[0m" "$@"
}

function white()
{
    local fmt=$1
    shift && printf "\033[1;38m${fmt}\033[0m" "$@"
}

# Colorful print end }}

# {{ Log set functions 

# Set default log level
function set_loglevel()
{
    if echo "$1" | grep -qE "^[0-9]+$"; then
        _log_level="$1"
    fi
}

# Set the log file
function set_logfile()
{
    if [ -n "$1" ]; then
        _log_file="$1"
    fi
}

# Set log format
function set_logfmt()
{
    if [ -n "$1" ]; then
        _log_fmt="$1"
    fi
}

# Set date format, see 'man date'
function set_datefmt()
{
    if [ -n "$1" ]; then
        _date_fmt="$1"
    fi
}

# Set log colors
function set_logcolor()
{
    local len=$#

    for (( i=0; i<$len; i++ )); do
        if echo "$SUPPORT_COLORS" | grep -wq "$1"
        then
            _log_color[$i]=$1
        else
            _log_color[$i]=''
        fi

        shift
    done
}

# Disable colorful log
function disable_logcolor()
{
    set_logcolor '' '' '' ''
}

# Reset color to default
function reset_logcolor()
{
    set_logcolor 'red' 'yellow' 'green' ''
}

# Log set functions }}