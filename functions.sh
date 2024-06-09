source variables.sh

# $1=SERVER_NAME
function get_server_configuration() {
    VAR='/\['$1'\]/,${p;/^\[*$/q}'

    sed -n $VAR $CONFIG_FILEPATH | grep "\S"
}

function show_help() {
    cat "help_messages/$1.txt"
}