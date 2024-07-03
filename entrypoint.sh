#!/bin/bash

set -e

ssh -NTC ${SSH_OPTS} -i ${SSH_KEY} \
    -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' \
	-o 'ServerAliveInterval=300' -o 'ExitOnForwardFailure=yes' ${SSH_DEST}
