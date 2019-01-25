#!/bin/bash

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
    echo_bold "\e[33$@"
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

SCRIPT_NAME="AWS CLI installer for Ubuntu"
print_banner
######################################################################################

print_stage "Installing Python3"
run sudo apt update && sudo apt install -y python3

print_stage "Installing Python3 PIP"
run sudo apt install -y python3-pip

print_stage "Installing AWS CLI"
run pip3 install awscli --upgrade --user

print_notes "If 'aws' command is not recognized, please re-login."
print_notes "Run 'aws configure' to configure"
######################################################################################
print_finished