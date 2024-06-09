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
CONFIG_FILEPATH=$HOME_DIR/.config/ssm/servers.ini
touch $CONFIG_FILEPATH
ln -sf $HOME_DIR/ssm/main.sh /usr/bin/ssm
ln -sf $HOME_DIR/ssm/main.sh /bin/ssm

CONFIG_FILEPATH="${CONFIG_FILEPATH//\//\\\/}"
sed -i s/CONFIG_FILEPATH=/CONFIG_FILEPATH=$CONFIG_FILEPATH/g variables.sh
sed -i s/INITIALLY_CONFIGURED=false/INITIALLY_CONFIGURED=true/g variables.sh