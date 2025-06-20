#!/usr/bin/env bash

set -euo pipefail

_git_root="$(git rev-parse --show-toplevel)"
_default_domain="$(jq -r '.domain' "${_git_root}/nix/.homelab.json")"

_host="$1"
_domain="${2:-$_default_domain}"
_fqdn="${_host}.${_domain}"

_host_key_dir="$(\
    bash "${_git_root}/scripts/prepare_ssh_host_keys.sh" "${_host}"\
)"

# Actually installing NixOS.
nixos-anywhere \
    --extra-files "${_host_key_dir}" \
    --chown /etc/ssh/ssh_host_ed25519_key 0:0 \
    --chown /etc/ssh/ssh_host_ed25519_key.pub 0:0 \
    --flake "${_git_root}/nix/#${_host}" \
    --target-host "root@${_fqdn}"

# Remove old SSH host key from known hosts.
ssh-keygen -R "${_fqdn}" > /dev/null 2>&1

# Waiting for host to come online.
bash "${_git_root}/scripts/wait_for_ssh.sh" "${_fqdn}"\

# Add SSH host key to known hosts.
ssh-keyscan "${_fqdn}" | sed '/^#.*/d' >> "${HOME}/.ssh/known_hosts"

# Print out age key.
ssh-keyscan -t ed25519 "${_fqdn}" | grep -vE '^#.*' | ssh-to-age

# Cleanup.
rm -rf "${_host_key_dir}"
