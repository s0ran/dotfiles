#!/bin/bash
USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
if [ $(id -u docker) -ne $USER_ID ]; then
    usermod -u $USER_ID docker
fi
if [ $(id -g docker) -ne $GROUP_ID ]; then
    usermod -g $GROUP_ID docker
fi
/bin/bash