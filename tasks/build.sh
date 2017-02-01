#!/bin/bash

set -e
set -u

cat << EOF > credentials.json
{
  "username": "${AUTH_USERNAME}",
  "password": "${AUTH_PASSWORD}"
}
EOF

cp -r broker-src/. broker-src-built

jq -s '.[0] * .[1]' broker-config/config-template.json credentials.json > \
  broker-src-built/config.json
