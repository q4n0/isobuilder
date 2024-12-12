
ISOBuilder: Advanced Linux Distribution Management Utility

Overview
========
ISOBuilder is a utility designed to help users customize and create Linux ISO images with ease. It provides options to extract the contents of an ISO, customize it (e.g., by adding files), and create a new ISO from the customized files.

Features
========
- Validate necessary dependencies
- Detect system information (OS, environment, installation location)
- Mount and extract an original ISO image
- Customize the extracted ISO (e.g., add files)
- Create a new custom ISO image
- Cleanup intermediate files and directories

Installation
============
Prerequisites
-------------
You will need to install the following dependencies:
- xorriso (for creating ISO images)
- squashfs-tools (for working with SquashFS files)
- rsync (for copying files)
- mount and umount (for mounting ISO files)

To install the required packages on Arch Linux:

    sudo pacman -S xorriso squashfs-tools rsync

Ensure that xorriso is installed as genisoimage is not available by default on Arch Linux.

Usage
=====
1. Download or clone the repository:

    git clone https://github.com/q4n0/isobuilder.git
    cd isobuilder

2. Make the script executable:

    chmod +x isobuilder.sh

3. Run the script:

    ./isobuilder.sh

Menu Options
============
- Validate Dependencies: Check if all necessary tools are installed.
- Detect System Information: Detects OS, environment (VM or Bare Metal), and installation location.
- Extract Original ISO: Mount and extract the contents of an original ISO image.
- Customize ISO: Customize the extracted ISO (e.g., by adding files such as a preseed file).
- Create Custom ISO: Create a new ISO from the customized files.
- Cleanup: Remove intermediate directories and unmount ISO files.
- Exit: Exit the program.

License
=======
MIT License

### Changes Summary:
1. **`genisoimage` replaced with `xorriso`**: This change was made to ensure compatibility with Arch Linux.
2. **Improved system info checks**: The script ensures the detection of OS, environment, and installation location is done correctly with additional error handling.
3. **Updated README**: The README now mentions Arch Linux-specific instructions for installing `xorriso` and details on how to use the script.
