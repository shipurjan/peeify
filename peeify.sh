#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
input=$1
resolution=${2:-2560}

[[ -z "$input" ]] && echo "Usage: peeify.sh <input> [resolution]" && exit 1

output=$(autoexif -i "$input")

# Use Sony's sRGB profile
srgb_profile="$SCRIPT_DIR/sRGB_v2.2.icc"

magick "$output" -profile "$srgb_profile" -resize "${resolution}x${resolution}>" -quality 90 "${input::-4}.p.jpg"
rm "$output"
