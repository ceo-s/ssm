source variables.sh

# $1=SERVER_NAME
function get_server_configuration() {
    VAR='/\['$1'\]/,${p;/^\[*$/q}'

    sed -n $VAR $CONFIG_FILEPATH | grep "\S"
}

function show_help() {

    echo "Usage: $PROJECT_NAME MODE [MODE_CPECIFIC_PARAMETERS]"

}