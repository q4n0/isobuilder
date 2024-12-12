# Advanced Linux ISO Conversion Utility

## Overview
An advanced, production-grade tool for converting Linux distributions to compressed, virtualization-ready ISOs with enhanced features.

## Creator
- **Name:** b0urn3
- **GitHub:** q4n0
- **Instagram:** onlybyhive

## Features
- Multi-distribution support (Debian, Arch, Ubuntu, Fedora)
- Advanced compression strategies
- Virtualization platform conversion
- Network boot configuration
- Secure boot preparation
- Machine learning-inspired compression optimization

## Prerequisites
### Required Dependencies
- xorriso
- squashfs-tools
- rsync
- qemu-utils
- tar
- xz-utils
- openssl
- gnupg

### Supported Linux Distributions
- Debian
- Arch Linux
- Ubuntu
- Fedora

## Installation

### Manual Installation
```bash
# Clone the repository
git clone https://github.com/q4n0/isobuilder
# Enter directory
cd isobuilder
# Make the script executable
chmod +x iso-converter.sh

# Optional: Install system-wide
sudo mkdir -p /usr/local/bin
sudo cp iso-converter.sh /usr/local/bin/iso-converter
```

### Dependency Installation
```bash
# Debian/Ubuntu
sudo apt-get install xorriso squashfs-tools rsync qemu-utils tar xz-utils openssl gnupg

# Arch Linux
sudo pacman -S libisoburn squashfs-tools rsync qemu-img tar xz openssl gnupg
```

## Usage

### Basic Conversion
```bash
# Standard Conversion
./iso-converter.sh debian.iso /output/directory

# Specify Compression Level
./iso-converter.sh debian.iso /output/directory --compression maximum

# Specify Virtualization Platform
./iso-converter.sh debian.iso /output/directory --platform vmware
```

### Advanced Options
```bash
# Enable Network Boot Configuration
./iso-converter.sh debian.iso /output/directory --network-boot

# Prepare Secure Boot Compatibility
./iso-converter.sh debian.iso /output/directory --secure-boot
```

## Compression Strategies
1. **Fast**: Minimal compression, maximum speed
2. **Standard**: Balanced compression and performance
3. **Maximum**: Highest compression rates, slower processing

## Virtualization Platforms
- VMware
- Hyper-V (Experimental)

## Logging
Conversion logs are stored in `/var/log/iso-converter/`
