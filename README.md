# Peeify - Image Optimization Scripts

A collection of bash scripts for converting and optimizing TIFF images to JPEG format with platform-specific presets.

## Overview

Peeify processes images by:
1. Removing EXIF metadata using `autoexif`
2. Applying sRGB color profile correction
3. Resizing images while maintaining aspect ratio
4. Compressing to JPEG with 90% quality

## Scripts

### Core Scripts

- **`peeify.sh`** - Main conversion script with customizable resolution
- **`peeify_all.sh`** - Batch processor for all TIFF files in current directory

### Platform Presets

- **`facebook.sh`** - Optimized for Facebook (2048px max dimension)
- **`instagram.sh`** - Optimized for Instagram (1080px max dimension)

## Usage

### Single File Conversion

```bash
# Basic conversion (default: 2560px max)
./peeify.sh input.tif

# Custom resolution
./peeify.sh input.tif 1920
```

### Platform-Specific

```bash
# Facebook-optimized
./facebook.sh input.tif

# Instagram-optimized
./instagram.sh input.tif
```

### Batch Processing

```bash
# Process all .tif files with default settings
./peeify_all.sh

# Process all .tif files with custom resolution
./peeify_all.sh peeify 1920

# Process all .tif files with Instagram preset
./peeify_all.sh instagram
```

## Dependencies

- **ImageMagick** (`magick` command)
- **autoexif** - EXIF metadata removal tool
- **sRGB_v2.2.icc** - Color profile (included)

## Output

- Original: `image.tif`
- Processed: `image.p.jpg`
- Temporary EXIF-stripped file is automatically cleaned up

## Technical Details

- **Quality**: 90% JPEG compression
- **Color Profile**: sRGB v2.2 ICC profile
- **Resize Strategy**: Maintain aspect ratio, resize to fit within specified dimensions
- **Metadata**: EXIF data stripped for privacy and reduced file size