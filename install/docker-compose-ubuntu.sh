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

SCRIPT_NAME="docker-compose for Ubuntu"
print_banner
######################################################################################

print_stage "Determing latest version"
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/docker/compose/releases/latest/ | awk -F "/" '{print $NF}')
print_notes "Detected version: $VERSION"

print_stage "Downloading docker-compose"
URL="https://github.com/docker/compose/releases/download/$VERSION/docker-compose-$(uname -s)-$(uname -m)"
run sudo curl -L "$URL" -o /usr/local/bin/docker-compose

print_stage "Making downloaded bin executable"
run sudo chmod +x /usr/local/bin/docker-compose

print_stage "Installing bash completion"
run sudo curl -L https://raw.githubusercontent.com/docker/compose/$VERSION/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
print_notes "Re-login to take effect or do 'su - ${USER}'"

######################################################################################
print_finished