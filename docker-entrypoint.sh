#!/bin/sh

if [ -n "${AUTHORIZED_KEYS}" ]; then
  echo "Populating /root/.ssh/authorized_keys with the value from AUTHORIZED_KEYS env variable ..."
  echo "${AUTHORIZED_KEYS}" > /root/.ssh/authorized_keys
fi

[ -n "${YIPFILE}" ] && cat "${YIPFILE}" | yip -s prestart -

# Execute the CMD from the Dockerfile:
exec "$@"

