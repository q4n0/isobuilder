# ISOBuilder: Advanced Linux Distribution Management Utility

## Overview

ISOBuilder is a powerful, flexible bash utility designed for advanced Linux distribution ISO manipulation, customization, and management. With robust features for network booting, secure boot preparation, and distribution-aware processing, ISOBuilder simplifies complex ISO management tasks.

## Features

- 🔒 **Root Permission Validation**
- 🛡️ **Comprehensive Dependency Checking**
- 🔍 **Automatic Distribution Detection**
- 🗜️ **Adaptive Compression Strategies**
- 🌐 **Network Boot Configuration Generation**
- 🔐 **Secure Boot Certificate Creation**

## Prerequisites

### System Requirements
- Linux-based Operating System
- Bash 4.0+
- Root/Sudo Access

### Required Packages
- xorriso (libisoburn)
- squashfs-tools
- rsync
- qemu-utils
- openssl

## Installation

### Manual Installation
```bash
# Clone the repository
git clone https://github.com/q4n0/isobuilder.git

# Make the script executable
chmod +x isobuilder/isobuilder.sh

# Optional: Add to system path
sudo ln -s $(pwd)/isobuilder/isobuilder.sh /usr/local/bin/isobuilder
```

## Usage

### Basic Usage
```bash
# Basic ISO customization
sudo ./isobuilder.sh -i input.iso -o /path/to/output
```

### Advanced Options
```bash
# Get help
./isobuilder.sh --help

# Show version
./isobuilder.sh --version
```

## Configuration

The tool uses a flexible configuration system. Key parameters can be modified directly in the script:

```bash
declare -A CONFIG=(
    [ROOT_CHECK_ENABLED]="true"
    [MAX_ISO_SIZE_GB]="10"
    [DEFAULT_COMPRESSION]="zstd"
    [NETWORK_BOOT_SUPPORT]="true"
    [SECURE_BOOT_ENABLED]="true"
    [DEBUG_MODE]="false"
)
```

## Logging

Logs are stored in `/var/log/isobuilder/isobuilder.log` with color-coded console output.

## Supported Distributions
- Debian/Ubuntu
- Arch Linux/Manjaro
- Fedora/CentOS/RHEL

## Security Considerations
- Requires root permissions
- Validates all dependencies
- Generates secure boot certificates
- Implements strict error handling

## Troubleshooting
- Ensure all dependencies are installed
- Check log files for detailed error information
- Run with `DEBUG_MODE="true"` for verbose output

## Contributing
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License
MIT License

## Author
b0urn3
Ig: onlybyhive
