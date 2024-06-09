#!/usr/bin/bash

source variables.sh

if [ "$INITIALLY_CONFIGURED" = true ] ; then
    ./configure.py && exit
fi

chmod +x login.sh
chmod +x list_servers.sh
chmod +x list_users.sh
chmod +x variables.sh
chmod +x functions.sh
chmod +x configure.sh


./make_initial_configuration $HOME