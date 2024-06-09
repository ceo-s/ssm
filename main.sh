#!/usr/bin/bash
source functions.sh

MODE=$1

case $MODE in
    login) ./login.sh $2 $3 && exit;;
    list_servers) ./list_servers.sh && exit;;
    list_users) ./list_users.sh $2 && exit;;
    configure) ;;
    --help) show_help && exit;;
    *) echo "Not a valid mode. Use \"$PROJECT_NAME --help\" for additional information" && exit 1
esac
