#!/usr/bin/env bash

set -euo pipefail

host="$1" domain="${2:-oliverwiegers.com}"
fqdn="${host}.${domain}"

host_key_file="${HOME}/.password-store/infrastructure/hosts/${host}/ssh_host_key.gpg"
tmp_dir="$(mktemp -d)"
tmp_dir_ssh="${tmp_dir}/etc/ssh"
host_key="${tmp_dir_ssh}/ssh_host_ed25519_key"

# Create needed folder structure for extra files.
mkdir -p "${tmp_dir_ssh}"

# Create SSH host key if none is existent yet. That usually means the system is
# a new one.
if [ ! -f "${host_key_file}" ]; then
    ssh-keygen -t ed25519 -f "${host_key}" -q -N ""

    pass insert -m "infrastructure/hosts/${host}/ssh_host_key" \
        > /dev/null 2>&1 \
        < "${host_key}"
    awk -v host="${host}" '{print $1, $2, "root@" host}' "${host_key}.pub" \
        | pass insert -m "infrastructure/hosts/${host}/ssh_host_key_pub"

    pass git push
fi

# Prepare SSH host key to be moved to new NixOS install.
pass "infrastructure/hosts/${host}/ssh_host_key" > "${host_key}"
chmod 0600 "${host_key}"
pass "infrastructure/hosts/${host}/ssh_host_key_pub" > "${host_key}.pub"
chmod 0644 "${host_key}.pub"

# Actually installing NixOS.
nixos-anywhere \
    --extra-files "${tmp_dir}" \
    --chown /etc/ssh/ssh_host_ed25519_key 0:0 \
    --chown /etc/ssh/ssh_host_ed25519_key.pub 0:0 \
    --flake ".#${host}" \
    --target-host "root@${fqdn}"

# Remove old SSH host key from known hosts.
ssh-keygen -R "${fqdn}" > /dev/null 2>&1

# Waiting for host to come online.
while ! ssh-keyscan "${fqdn}" -T 1 > /dev/null 2>&1; do
    printf '%s\n' 'Waiting for SSH on remote host to come online.'
    sleep 1;
done

# Add SSH host key to known hosts.
ssh-keyscan "${fqdn}" | sed '/^#.*/d' >> "${HOME}/.ssh/known_hosts"

# Print out age key.
ssh-keyscan -t ed25519 "${fqdn}" | grep -vE '^#.*' | ssh-to-age

# Cleanup.
rm -rf "${tmp_dir}"
