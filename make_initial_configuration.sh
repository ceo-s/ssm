#!/usr/bin/bash

source variables.sh

HOME_DIR=$1

chmod +x login.sh
chmod +x list_servers.sh
chmod +x list_users.sh
chmod +x variables.sh
chmod +x functions.sh
chmod +x configure.sh
mkdir $HOME_DIR/.config/ssm
touch $HOME_DIR/.config/ssm/servers.ini
ln -sf $HOME_DIR/ssm/main.sh /usr/bin/ssm
ln -sf $HOME_DIR/ssm/main.sh /bin/ssm