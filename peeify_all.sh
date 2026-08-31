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

printf '%s\0' *.tif | xargs -0 -P "$jobs" -I{} bash -c 'process "$@"' _ {}
