source ./functions.sh

SERVER_NAME=$1
SERVER_INFO=$(get_server_configuration $SERVER_NAME)
USERS_LIST_STRING=$(echo "$SERVER_INFO" | grep -i users | cut -d '=' -f 2 | sed 's/^ *//g' | tr ' ' '\n')
echo
echo "List of valid users for $SERVER_NAME:"
echo
echo "$(echo "$USERS_LIST_STRING" | nl -w1 -n ln -s ') ')"
echo