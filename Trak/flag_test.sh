#! /bin/bash

# set -o errexit
# set -o pipefail
# set -o nounset

# A help menu showing how to use the scritp and what the expected output is.
_usage() {
cat << EOF
${0} NAME COUNTRY -i|--interests X[,Y] [-c|--cool]

Output:
  Name: NAME
  Country: COUNTRY
  Interests: X,Y
  Cool?: (true|false)
EOF
}

main() {
    # Positional arguments.
    local position=0
    local name=
    local country=

    # Flag arguments.
    local interests=
    local cool="false"

    # Count all of the args passed into the script and
    # continue looping while we have them.
    while [[ "${#}" -gt 0 ]]; do
        # Determine which arg we're working with.
        case "${1}" in
            # Optimize for happiness and support multiple variants.
            -h|--help)
                _usage
                exit 0
                ;;
            -i|--interests)
                # Set the value so we can use it later in the script.
                interests="${2:-}"

                # Interests requires a value so we'll make sure it's not empty.
                # If it's empty we'll let the user know and print a message to stderr.
                [[ -z "${interests}" ]] &&
                    printf "%s must have a value\n\n" "${1}" >&2 &&
                    _usage >&2 &&
                    exit 1

                # Pop the first 2 elements off the list of arguments in $@, in this case
                # that's the -i|--interests flag and it's value. This lets us break out
                # of the while loop because we'll eventually reach 0 args.
                shift 2
                ;;
            -c|--cool)
                # Set the value so we can use it later in the script.
                cool="true"

                # We onle need to pop the first element off the list of arguments
                # since this flag doesn't have a value.
                shift
                ;;
            # We've handled all our flags, now it's time to consider positional args.
            *)
            # Determine which position we're at (set to 0 earler)
            case "${position}" in
                0)
                    # Set the value so we can use it later in the script.
                    name="${1}"

                    # We've processed this p.arg, so ++ and shift
                    position=1
                    shift
                    ;;
                1)
                    # The same as above.
                    country="${1}"
                    position=2
                    shift
                    ;;
                2)
                    # The user called the script with an unexpected arg -> bail
                    printf "Unknown argument: %s\n\n" "${1}" >&2
                    _usage >&2
                    exit 1
                    ;;
            esac
        esac
    done

        # Validation.
        [[ -z "${name}" ]] && printf "Requires NAME\n\n" >&2 && _usage && exit 1
        [[ -z "${country}" ]] && printf "Requires COUNTRY\n\n" >&2 && _usage && exit 1
        [[ -z "${interests}" ]] && printf "Requires --interests X[,Y]\n\n" >&2 && _usage && exit 1

        # The script's logic now that the inputs are defined.
        echo "Name: ${name}"
        echo "Country: ${country}"
        echo "Interests: ${interests}"
        [[ "${cool}" == "true" ]] && echo "Cool?: ${cool}"

        return 0
}

main "${@:-}"
