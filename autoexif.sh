#!/bin/bash
# Runs a pinned autoexif via npx, so it doesn't need a global install.
# Bump the version here to upgrade it for every script.
AUTOEXIF_VERSION=2.1.0
exec npx --yes "autoexif@$AUTOEXIF_VERSION" "$@"
