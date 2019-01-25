#!/bin/bash

function echo_bold {
    echo -e "\e[1m$@\e[0m"
}

function echo_dim {
    echo -e "\e[90m$@\e[0m"
}
function echo_red {
    echo_bold "\e[31m$@\e[0m"
}
function echo_green {
    echo_bold "\e[32m$@\e[0m"
}
function echo_light_blue {
    echo_bold "\e[94m$@\e[0m"
}

function print_banner {
    echo_bold "======================================"
    echo_bold "=      DACHA204 AUTOMATION SCRIPT    ="
    echo_bold "=               NAME                 ="
    echo_bold "======================================"
    echo ""
}

function print_stage {
    echo_bold "==> $@"
}
function print_finished {
    echo_green "Completed"

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

print_banner
######################################################################################

## COMMANDS HERE

######################################################################################
print_finished