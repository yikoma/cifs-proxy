#!/bin/bash

set -e

SSHD_CONFIG_FILEPATH="${SSHD_CONFIG_FILEPATH:-/etc/ssh/sshd_config}"
SSH_HOSTKEY_FILEPATH="${SSH_HOSTKEY_FILEPATH:-/etc/ssh/ssh_host_key}"

## update the sshd_config file
echo "HostKey ${SSH_HOSTKEY_FILEPATH}" >> "${SSHD_CONFIG_FILEPATH}"
echo "PubkeyAuthentication yes" >> "${SSHD_CONFIG_FILEPATH}"
echo "PasswordAuthentication no" >> "${SSHD_CONFIG_FILEPATH}"
echo "PermitRootLogin yes" >> "${SSHD_CONFIG_FILEPATH}"
echo "StrictModes yes" >> "${SSHD_CONFIG_FILEPATH}"

## prepare the ~/.ssh/authorized_keys
SSH_PUBKEY_FILEPATH="${SSH_PUBKEY_FILEPATH:-/conf/id_key.pub}"
SSH_AUTHKEYS_FILEPATH="${SSH_AUTHKEYS_FILEPATH:-/root/.ssh/authorized_keys}"
SSH_AUTHKEYS_BASEDIR="$(dirname ${SSH_AUTHKEYS_FILEPATH})"
mkdir -p "${SSH_AUTHKEYS_BASEDIR}"
chmod 700 "${SSH_AUTHKEYS_BASEDIR}"
cp "${SSH_PUBKEY_FILEPATH}" "${SSH_AUTHKEYS_FILEPATH}"
chmod 0600 "${SSH_AUTHKEYS_FILEPATH}"

## change the root password
echo "root:$(openssl rand -hex 12)" | chpasswd

ssh -NTC ${SSH_OPTS} -i ${SSH_KEY} \
    -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' \
	-o 'ServerAliveInterval=300' -o 'ExitOnForwardFailure=yes' ${SSH_DEST}
