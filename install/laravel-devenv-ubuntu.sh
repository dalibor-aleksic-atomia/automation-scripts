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

SCRIPT_NAME="LA(M)P Stack + Debugging"
print_banner
######################################################################################

print_stage "Enable universe"
run sudo add-apt-repository universe -y

print_stage "Update system"
run sudo apt update

print_stage "Upgrade system"
run sudo apt upgrade -y

print_stage "Install Apache"
run sudo apt install apache2 -y

print_stage "Install Apache PHP Module" 
run sudo apt install libapache2-mod-php -y

print_stage "Enable Apache mods"
run sudo a2enmod rewrite

print_stage "Write dir.conf"
run sudo tee /etc/apache2/mods-enabled/dir.conf > /dev/null << EOF
<IfModule mod_dir.c>
    DirectoryIndex index.php index.cgi index.pl index.html index.xhtml index.htm
</IfModule>
EOF

print_stage "Install PHP"
run sudo apt install php -y 

print_stage "Install PHP Plugins"
run sudo apt install php-curl php-json php-cgi php-mysql php-mbstring php-gd php-xdebug php-cli php-dom -y

print_stage "Restart Apache"
run sudo systemctl restart apache2

print_stage "Writing phpinfo.php"
run sudo tee /var/www/html/phpinfo.php > /dev/null << EOF
<?php phpinfo(); ?>
EOF

print_stage "www-data owning"
run sudo chown www-data:www-data /var/www/html

print_stage "Install composer prerequirements"
run sudo apt install curl git unzip -y

print_stage "Install composer"
run sudo apt install composer -y

print_stage "Download Lumen Installer"
run composer global require "laravel/lumen-installer"

######################################################################################
print_finished