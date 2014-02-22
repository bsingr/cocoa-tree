#!/bin/bash
set -e
set -u

SSH_KEYFILE_NAME=$1
SCRIPTS_DIR=$(dirname $0)
shift

SSH_KEYFILE=$SSH_KEYFILE_NAME GIT_SSH=$SCRIPTS_DIR/ssh-as.sh git $@
