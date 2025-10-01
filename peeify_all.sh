#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
scriptname=${1:-peeify}
resolution=${2:-2560}

for file in *.tif; do 
    echo "Processing $file..."
    $SCRIPT_DIR/$scriptname.sh "$file" "$resolution"
done
