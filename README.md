# Linux Advanced ISO Builder

## Overview

This utility provides a robust, production-grade solution for creating custom Linux live ISO images with advanced kernel management capabilities.

## Features

- **Dynamic Kernel Detection**: Automatically discovers and lists all available Linux kernels
- **Interactive Kernel Selection**: Choose multiple kernels for inclusion in your custom ISO
- **Comprehensive Package Customization**: Add or remove packages interactively
- **Production-Grade Error Handling**: Strict error checking and detailed logging
- **Flexible ISO Generation**: Support for multiple kernel versions and configurations

## Prerequisites

### System Requirements
- Arch Linux or BlackArch Linux base system
- Minimum 20GB free disk space
- Root/sudo access

### Required Packages
- squashfs-tools
- libisoburn
- grub
- rsync
- arch-install-scripts
- pacman

## Installation

1. Clone the repository or download the script
2. Make the script executable:
   ```bash
   chmod +x archisobuilder.sh
   ```

## Usage

### Basic Usage
```bash
./archisobuilder.sh
```

### Workflow
1. System Dependency Check
2. Package Customization
   - Add/Remove packages
3. Kernel Selection
   - Choose which kernels to include
4. ISO Generation

## Logging

- Detailed logs are stored in `/var/log/blackarch-iso-builder-TIMESTAMP.log`
- Provides comprehensive error tracking and system information

## Advanced Configuration

### Kernel Selection
- Select multiple kernels for inclusion
- Supports LTS, ZEN, and standard kernel variants

### Package Management
- Interactive package addition/removal
- Flexible customization options

## Troubleshooting

### Common Issues
- **Dependency Errors**: Ensure all required packages are installed
- **Kernel Selection**: Verify kernel files exist in `/boot`
- **ISO Generation**: Check system resources and disk space

### Error Codes
- Detailed error messages in log files
- Specific error codes for precise issue identification

## Security Considerations
- Runs with strict error handling
- Minimal system modifications
- Temporary build directories automatically cleaned

## Performance Optimization
- Uses `xz` compression for minimal ISO size
- Supports multiple kernel configurations
- Efficient squashfs generation

## Contribution

Contributions are welcome! Please submit pull requests or open issues on the project repository.

## Disclaimer

This script is provided "AS IS" without warranty. Always backup your system before generating custom ISOs.

## Contact

For support, please open an issue on the project repository.
