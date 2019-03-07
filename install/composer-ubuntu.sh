#!/bin/bash
## Template: v1.1

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
function require_var {
    VAL=${!1}
    if [[ -z $VAL ]]; then
        echo_red "Environment variable $1 is required."
        exit 1
    fi  
}
SCRIPT_NAME="Install composer ubuntu"
print_banner
######################################################################################

RETURN_POINT="$(pwd)"
cd /tmp

print_stage "Install composer additions"
run sudo apt install curl git unzip -y

print_stage "Install composer"
run wget https://getcomposer.org/installer -O composer-setup.php
run sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
run rm composer-setup.php

print_stage "Verify installation"
run composer --version

cd $RETURN_POINT
######################################################################################
print_finished