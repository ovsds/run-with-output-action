#!/bin/bash

set -euo pipefail

function set_output() {
    KEY=$1
    VALUE=$2

    echo "$KEY"
    echo "$VALUE"
    {
        echo "$KEY<<EOF"
        echo "$VALUE"
        echo "EOF"
    } >> "$GITHUB_OUTPUT"
}

function main() {
    if [ -z "${COMMAND:-}" ]; then
        echo "ERROR: COMMAND is not set, exiting..." >&2
        exit 1
    fi

    # run the command and capture the output
    {
        IFS=$'\n' read -r -d '' CAPTURED_STDOUT;
        IFS=$'\n' read -r -d '' CAPTURED_STDERR;
    } < <((printf '\0%s\0' "$(({
        eval "$COMMAND"
    } | tr -d '\0') 3>&1- 1>&2- 2>&3- | tr -d '\0')" 1>&2) 2>&1)

    set_output "stdout" "$CAPTURED_STDOUT"
    set_output "stderr" "$CAPTURED_STDERR"
}

main "$@"
