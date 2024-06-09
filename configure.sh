#!/usr/bin/bash

source variables.sh

if [ "$INITIALLY_CONFIGURED" = false ] ; then
    chmod +x login.sh
    chmod +x list_servers.sh
    chmod +x list_users.sh
    chmod +x variables.sh
    chmod +x functions.sh
    chmod +x make_initial_configuration.sh

    echo "Making an initial configuration. Enter sudo password:"
    read -s SUDO_PASSWORD
    echo $SUDO_PASSWORD | sudo -S ./make_initial_configuration.sh $HOME
fi

./configure.py && exit