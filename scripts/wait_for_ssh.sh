#!/usr/bin/env bash

_host="${1}"

while ! ssh-keyscan "${_host}" -T 1 > /dev/null 2>&1; do
    printf 'Waiting for SSH on host: "%s" to come online.\n' "${_host}"
    sleep 1;
done
