#!/bin/bash

set -e

echo "Generating environment variables for Spruce merge"

cat <<-EOF >> manifest.secret.yml
applications:
  - name: uaa-guard-broker
    env:
      GUARD_BROKER_USERNAME: ${GUARD_BROKER_USERNAME}
      GUARD_BROKER_PASSWORD: ${GUARD_BROKER_PASSWORD}
      GUARD_ROUTE_SERVICE_URL: ${GUARD_ROUTE_SERVICE_URL}
  - name: uaa-guard-proxy
    env:
      GUARD_COOKIE_SECRET: ${GUARD_COOKIE_SECRET}
      GUARD_DEFAULT_CALLBACK_URL: ${GUARD_DEFAULT_CALLBACK_URL}
      GUARD_UAA_URL: ${GUARD_UAA_URL}
      GUARD_CLIENT_KEY: ${GUARD_CLIENT_KEY}
      GUARD_CLIENT_SECRET: ${GUARD_CLIENT_SECRET}
EOF

echo "Copy all source files into built directory"

cp -v broker-src/* broker-src-built/*
rm -rvf broker-src-built/manifest.yml.sample

echo "Merging in manifest template with secrets"

spruce merge broker-src/manifest.yml.sample \
             manifest.secret.yml > broker-src-built/manifest.yml
