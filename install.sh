#!/bin/bash

# Peeify Installation Script for Debian
# Installs autoexif and ImageMagick with required libraries

set -e  # Exit on any error

echo "🚀 Installing Peeify dependencies on Debian..."

# Check if running on Debian/Ubuntu
if ! command -v apt &> /dev/null; then
    echo "❌ Error: This script is designed for Debian/Ubuntu systems only"
    exit 1
fi

# Check if running as root or with sudo
if [[ $EUID -eq 0 ]]; then
    SUDO=""
else
    SUDO="sudo"
fi

echo "📦 Updating package lists..."
$SUDO apt update

echo "📚 Installing required libraries for ImageMagick..."
$SUDO apt install -y \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    libgif-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libxml2-dev \
    build-essential

echo "🎨 Installing ImageMagick..."
$SUDO apt install -y imagemagick

# Check if Node.js/npm is installed
if ! command -v npm &> /dev/null; then
    echo "📦 Node.js/npm not found, installing..."
    $SUDO apt install -y nodejs npm

    # Verify npm is now available
    if ! command -v npm &> /dev/null; then
        echo "❌ Error: npm installation failed or not in PATH"
        echo "Please install Node.js and npm manually and run this script again"
        exit 1
    fi
fi

echo "🔧 Installing autoexif globally..."
npm install -g autoexif

echo "✅ Verifying installations..."

# Verify ImageMagick
if command -v magick &> /dev/null; then
    echo "✓ ImageMagick installed: $(magick -version | head -n1)"
else
    echo "❌ ImageMagick installation failed"
    exit 1
fi

# Verify autoexif
if command -v autoexif &> /dev/null; then
    echo "✓ autoexif installed: $(autoexif --version 2>/dev/null || echo 'version not available')"
else
    echo "❌ autoexif installation failed"
    exit 1
fi

# Check for sRGB profile
if [[ -f "sRGB_v2.2.icc" ]]; then
    echo "✓ sRGB color profile found"
else
    echo "⚠️  Warning: sRGB_v2.2.icc profile not found in current directory"
fi

echo ""
echo "🎉 Installation complete!"
echo "You can now use the peeify scripts to optimize your images."
echo ""
echo "Usage examples:"
echo "  ./peeify.sh image.tif"
echo "  ./facebook.sh image.tif"
echo "  ./instagram.sh image.tif"
echo "  ./peeify_all.sh facebook"