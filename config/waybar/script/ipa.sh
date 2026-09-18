#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

IFACE=$(default_iface)
IP=$(ip -4 addr show "$IFACE" 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

echo "${IP:-0.0.0.0}"
