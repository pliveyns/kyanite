#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
set -oue pipefail

# Install Balena Etcher rpm package
echo "Installing Balena Etcher rpm ---"

package_url="https://github.com/balena-io/etcher/releases/download/v1.18.13/balena-etcher-1.18.13.x86_64.rpm"
curl -L $package_url -o /tmp/balena-etcher.rpm
sudo dnf localinstall /tmp/balena-etcher.rpm

