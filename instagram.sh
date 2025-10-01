#!/bin/bash

[[ -z $1 ]] && echo "Usage: facebook.sh <input>" && exit 1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
"$SCRIPT_DIR/peeify.sh" "$1" 1080