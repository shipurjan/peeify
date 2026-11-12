#!/bin/bash

[[ -z $1 ]] && echo "Usage: instagram.sh <input>" && exit 1
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

input=$1
output=$(autoexif -i "$input")

srgb_profile="$SCRIPT_DIR/sRGB_v2.2.icc"

dims=$(magick identify -format "%wx%h" "$output")
w=${dims%x*}

h=${dims#*x}

if ((h > w)); then
  # Vertical — fit within 1080x1350, then pad sides with black
  magick "$output" -profile "$srgb_profile" -resize "1080x1350" \
    -gravity center -background black -extent 1080x1350 \
    -quality 90 "${input::-4}.p.jpg"
else
  # Horizontal/square — scale width to 1080
  magick "$output" -profile "$srgb_profile" -resize "1080x>" \
    -quality 90 "${input::-4}.p.jpg"
fi

rm "$output"
