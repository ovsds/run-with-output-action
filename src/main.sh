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

    stdout_file=$(mktemp)
    stderr_file=$(mktemp)

    set +e
    eval "$COMMAND" 1> "$stdout_file" 2> "$stderr_file" | true; exit_code=$?
    stdout=$(cat "$stdout_file")
    stderr=$(cat "$stderr_file")
    set -e

    rm -f "$stdout_file" "$stderr_file"

    set_output "stdout" "$stdout"
    set_output "stderr" "$stderr"
    set_output "exit_code" "$exit_code"
}

main "$@"
