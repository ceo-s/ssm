#!/usr/bin/bash
source functions.sh

MODE=$1

case $MODE in
    login) ./login.sh $2 $3 && exit;;
    list_servers) ./list_servers.sh && exit;;
    list_users) ./list_users.sh $2 && exit;;
    configure) chmod +x configure.sh && ./configure.sh && exit;;
    --help) show_help "main" && exit;;
    *) show_help "main" && exit 1
esac
