#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
input=$1
resolution=${2:-2560}

[[ -z "$input" ]] && echo "Usage: peeify.sh <input> [resolution]" && exit 1

# Use Sony's sRGB profile
srgb_profile="$SCRIPT_DIR/sRGB_v2.2.icc"

tmp=$(mktemp --suffix=.jpg)
trap 'rm -f "$tmp"' EXIT

# Convert first: ImageMagick drops all EXIF when converting from TIFF...
magick "$input" -profile "$srgb_profile" -resize "${resolution}x${resolution}>" -quality 90 "$tmp"

# ...then restore the cleaned metadata from the original
"$SCRIPT_DIR/autoexif.sh" -i "$tmp" --tags-from "$input" -o "${input::-4}.p.jpg" > /dev/null
