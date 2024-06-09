#!/usr/bin/bash

source variables.sh

if [ "$INITIALLY_CONFIGURED" = false ] ; then
    chmod +x make_initial_configuration.sh
    mkdir ~/.config/ssm
    CONFIG_FILEPATH=~/.config/ssm/servers.ini
    touch $CONFIG_FILEPATH

    echo "Making an initial configuration. Enter sudo password:"
    read -s SUDO_PASSWORD
    echo $SUDO_PASSWORD | sudo -S ./make_initial_configuration.sh $HOME
fi

./configure.py $CONFIG_FILEPATH && exit