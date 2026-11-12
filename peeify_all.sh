#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
scriptname=${1:-peeify}
resolution=${2:-2560}
jobs=${JOBS:-$(nproc)}

process() {
    echo "Processing $1..."
    "$SCRIPT_DIR/$scriptname.sh" "$1" "$resolution"
}
export -f process
export SCRIPT_DIR scriptname resolution

# Warm the npx cache once before going parallel, so the jobs don't all race
# to download autoexif into ~/.npm/_npx at the same time.
if ! "$SCRIPT_DIR/autoexif.sh" --version >/dev/null 2>&1; then
    echo "❌ Could not fetch autoexif via npx (offline? npm missing?)." >&2
    echo "   Try: $SCRIPT_DIR/autoexif.sh --version" >&2
    exit 1
fi

printf '%s\0' *.tif | xargs -0 -P "$jobs" -I{} bash -c 'process "$@"' _ {}
