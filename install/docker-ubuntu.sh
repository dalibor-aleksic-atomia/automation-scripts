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
    echo_bold "=       Ubuntu Docker installer      ="
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

print_stage "Fetching GPG key"
run curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

print_stage "Adding Docker repository"
run sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

print_stage "APT update"
run sudo apt-get update

print_stage "Installing docker-ce"
run sudo apt-get install -y docker-ce

print_stage "Allowing executing docker without sudo"
run sudo usermod -aG docker ${USER}

print_finished