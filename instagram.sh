#!/bin/bash

[[ -z $1 ]] && echo "Usage: instagram.sh <input>" && exit 1
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

input=$1

srgb_profile="$SCRIPT_DIR/sRGB_v2.2.icc"

tmp=$(mktemp --suffix=.jpg)
trap 'rm -f "$tmp"' EXIT

dims=$(magick identify -format "%wx%h" "$input")
w=${dims%x*}

h=${dims#*x}

# Convert first: ImageMagick drops all EXIF when converting from TIFF...
if ((h > w)); then
  # Vertical — fit within 1080x1350, then pad sides with black
  magick "$input" -profile "$srgb_profile" -resize "1080x1350" \
    -gravity center -background black -extent 1080x1350 \
    -quality 90 "$tmp"
else
  # Horizontal/square — scale width to 1080
  magick "$input" -profile "$srgb_profile" -resize "1080x>" \
    -quality 90 "$tmp"
fi

# ...then restore the cleaned metadata from the original
"$SCRIPT_DIR/autoexif.sh" -i "$tmp" --tags-from "$input" -o "${input::-4}.p.jpg" >/dev/null
