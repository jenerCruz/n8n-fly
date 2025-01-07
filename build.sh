#!/bin/sh

# Exit on error
set -e

echo "Starting setup process..."

# Create custom nodes directory
echo "Creating custom nodes directory and database dir"
chown node:node .n8n
mkdir -p .n8n/customnodes
chown node:node .n8n/customnodes
mkdir -p .n8n/database
chown node:node .n8n/database


# Install custom n8n node
echo "Installing custom n8n node..."
corepack prepare pnpm@latest --activate
COREPACK_ENABLE_NETWORK=1 COREPACK_YES=1 pnpm install --prefix '/home/node/.n8n/customnodes' '/home/node/n8n-custom-0.1.0.tgz'

echo "Setup completed successfully!"