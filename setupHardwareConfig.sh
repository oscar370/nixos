#!/usr/bin/env bash

set -e

FLAKE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Setting up NixOS flake configuration..."

cp -f /etc/nixos/hardware-configuration.nix "$FLAKE_DIR/host/hardware-configuration.nix"

echo "Settings copied"

echo "Now configure your files"

echo "Then run: sudo nixos-rebuild switch --flake .#nixos"