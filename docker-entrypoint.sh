#!/bin/sh
set -e

if [ -d /opt/custom-certificates ]; then
  echo "Trusting custom certificates from /opt/custom-certificates."
  export NODE_OPTIONS=--use-openssl-ca $NODE_OPTIONS
  export SSL_CERT_DIR=/opt/custom-certificates
  c_rehash /opt/custom-certificates
fi

# Install custom nodes if present
# if [ -f "/home/node/n8n-custom-0.1.0.tgz" ]; then
#   echo "Installing custom nodes..."
#   cd /home/node/.n8n
#   npm install /home/node/n8n-custom-0.1.0.tgz
# fi

# Ensure proper permissions for n8n directory
if [ -d "/home/node/.n8n" ]; then
  chmod -R 755 /home/node/.n8n
fi

# Start n8n
if [ "$#" -gt 0 ]; then
  # Got started with arguments
  exec n8n "$@"
else
  # Got started without arguments
  exec n8n start
fi
