#!/bin/bash
## Template: v1.4

function echo_bold {
    echo -e "\e[1m$@\e[0m"
}
function echo_dim {
    echo -e "\e[90m$@\e[0m"
}
function echo_red {
    echo_bold "\e[31m$@"
}
function echo_green {
    echo_bold "\e[32m$@"
}
function echo_light_blue {
    echo_bold "\e[94m$@"
}
function echo_yellow {
    echo_bold "\e[33m$@"
}
function echo_magenta {
    echo_bold "\e[95m$@"
}

function print_banner {
    echo_bold "======================================"
    echo_bold "=      DACHA204 AUTOMATION SCRIPT    ="
    echo_bold "======================================"
    echo_light_blue "Script: $SCRIPT_NAME"
    echo ""
}
function print_stage {
    echo ""
    echo_bold "==> $@"
}
function print_warrning {
    echo_yellow "$@"
}
function print_finished {
    echo_green "*** Completed ***"
    echo ""
}
function print_notes {
    echo_magenta "$@"
}

function check_execution {
    returnValue=$?
    if [ $returnValue -ne 0 ]; then
        echo_red "Failed!\nReturnCode: " $returnValue 
        exit $returnValue
    fi
    echo_light_blue "Status: \e[90mOK"
}
function run {
    echo_light_blue "Command: \e[90m$@"
    "$@"
    check_execution
}
function try_run {
		echo_light_blue "Command (try): \e[90m$@"
		"$@"
		echo_light_blue "Status: \e[90m$?"
}

function require_var {
    VAL=${!1}
    if [[ -z $VAL ]]; then
        echo_red "ENVIRONMENT VARIABLE REQUIRED: $1"
        exit 1
    else
        echo_green "ENVIRONMENT VARIABLE OK: $1"
    fi  
}

function require_file {
    if [[ ! -f $1 ]]; then
      echo_red "FILE REQUIRED: $1"
      exit 1
    else
      echo_green "REQUIRED FILE OK: $1"
    fi
}

SCRIPT_NAME="TEMPLATE"
print_banner
######################################################################################

## COMMANDS HERE

######################################################################################
print_finished
