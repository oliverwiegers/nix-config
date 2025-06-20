#!/usr/bin/env bash

_host="${1:-$TARGET_HOST}"

_host_key_file="${HOME}/.password-store/infrastructure/hosts/${_host}/ssh_host_key.gpg"
_tmp_dir="$(mktemp -d)"
_tmp_dir_ssh="${_tmp_dir}/etc/ssh"
_host_key="${_tmp_dir_ssh}/ssh_host_ed25519_key"

# Create needed folder structure for extra files.
mkdir -p "${_tmp_dir_ssh}"

# Create SSH host key if none is existent yet. That usually means the system is
# a new one.
if [ ! -f "${_host_key_file}" ]; then
    ssh-keygen -t ed25519 -f "${_host_key}" -q -N ""

    pass insert -m "infrastructure/hosts/${_host}/ssh_host_key" \
        > /dev/null 2>&1 \
        < "${_host_key}"
    awk -v host="${_host}" '{print $1, $2, "root@" host}' "${_host_key}.pub" \
        | pass insert -m "infrastructure/hosts/${_host}/ssh_host_key_pub"

    pass git push
fi

# Prepare SSH host key to be moved to new NixOS install.
pass "infrastructure/hosts/${_host}/ssh_host_key" > "${_host_key}"
chmod 0600 "${_host_key}"
pass "infrastructure/hosts/${_host}/ssh_host_key_pub" > "${_host_key}.pub"
chmod 0644 "${_host_key}.pub"

if [ "${CI}" == "true" ]; then
    mv "${_tmp_dir}/etc" ./
    rm -rf "${_tmp_dir}"
else
    printf '%s\n' "${_tmp_dir}"
fi
