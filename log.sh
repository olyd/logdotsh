#!/bin/echo Warnning, this library must only be sourced!
# vim: set expandtab smarttab shiftwidth=4 tabstop=4:

#
# Author: tuantuan.lv <dangoakachan@foxmail.com>
# Status: Development
# Description: defines functions for printing log messages.
#

# Don't show log whose level greater than this
log_level=3

# Log level constants
LOG_ERROR=0       # Level error
LOG_WARNING=1     # Level warning
LOG_INFO=2        # Level info
LOG_DEBUG=3       # Level debug

# Color escape string
COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_BLUE="\033[34m"
COLOR_PURPLE="\033[35m"
COLOR_CYAN="\033[36m"
COLOR_GRAY="\033[37m"
COLOR_WHITE="\033[38m"
COLOR_RESET="\033[0m"

# Log prompt string
LOG_PROMPT=("${COLOR_RED}[ERROR]${COLOR_RESET}"
    "${COLOR_YELLOW}[WARNING]${COLOR_RESET}"
    "${COLOR_BLUE}[INFO]${COLOR_RESET}"
    "[DEBUG]")

# {{ LOG functions start

# Show debug log messages
# $1: Log level
# $2: C style printf format
# $3: C style printf arguments
function do_debug()
{
    local level=$1
    local format=$2
    local prompt=${LOG_PROMPT[$level]}

    if [ $level -gt $log_level ]; then
        return
    else
        shift 2 && printf "${prompt} ${format}" "$@"
    fi
}

# Print debug messages
function debug_msg()
{
    local format=$1
    shift && do_debug $LOG_DEBUG "$format" "$@"
}

# Print information messages
function info_msg()
{
    local format=$1
    shift && do_debug $LOG_INFO "$format" "$@"
}

# Print warning messages
function warn_msg()
{
    local format=$1
    shift && do_debug $LOG_WARNING "$format" "$@"
}

# Print error messages
function error_msg()
{
    local format=$1
    shift && do_debug $LOG_ERROR "$format" "$@"
    return 1
}

# Print error messages and then exit the script
function exit_msg()
{
    local format=$1

    shift && do_debug $LOG_ERROR "$format" "$@"
    exit 1
}

# Set the maximum log level
function set_loglevel()
{
    log_level=$1
}

# LOG functions end }}

# Colorful print start {{

function red()
{
    printf "${COLOR_RED}${1}${COLOR_RESET}"
}

function green()
{
    printf  "${COLOR_GREEN}${1}${COLOR_RESET}"
}

function gray()
{
    printf "${COLOR_GRAY}${1}${COLOR_RESET}"
}

function yellow()
{
    printf "${COLOR_YELLOW}${1}${COLOR_RESET}"
}

function blue()
{
    printf "${COLOR_BLUE}${1}${COLOR_RESET}"
}

function cyan()
{
    printf "${COLOR_CYAN}${1}${COLOR_RESET}"
}

function purple()
{
    printf "${COLOR_PURPLE}${1}${COLOR_RESET}"
}

# Colorful print end }}
