#!/usr/bin/bash
source functions.sh

USER_NAME=$1
SERVER_NAME=$2
SERVER_INFO=$(get_server_configuration $SERVER_NAME)

SERVER_IP=$(echo "$SERVER_INFO" | grep IP | cut -d '=' -f 2 | tr -d ' ')


ssh $USER_NAME@$SERVER_IP