#!/usr/bin/env bash

# ISOBuilder: Advanced Linux Distribution Management Utility
# Version: 4.2.0
# Author: bo0urn3 (GitHub: q4n0, IG: onlybyhive)
# License: MIT

# Strict error handling and advanced debugging
set -Eeuo pipefail
trap 'log "Error occurred on line $LINENO."' ERR

# Global variables for default directories and files
ORIGINAL_ISO=""
CUSTOM_ISO_DIR="custom_iso"
OUTPUT_ISO="custom_linux.iso"
LOG_FILE="isobuilder.log"
MOUNT_DIR="/mnt/iso_mount"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Validate dependencies
validate_dependencies() {
    log "Validating dependencies..."
    local dependencies=(xorriso squashfs-tools rsync mount umount)
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            log "Error: $dep is not installed. Exiting." >&2
            exit 1
        fi
    done
    log "All dependencies are satisfied."
}

# Detect running OS
check_os() {
    log "Detecting running OS..."
    local os_name=$(uname -s)
    local os_version=""
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        os_name="$NAME"
        os_version="$VERSION"
    fi
    log "Running OS: $os_name $os_version"
}

# Detect installation environment
check_environment() {
    log "Detecting installation environment..."
    if grep -q hypervisor /proc/cpuinfo; then
        if systemd-detect-virt -q --vmware; then
            log "Environment: VMware"
        elif systemd-detect-virt -q --oracle; then
            log "Environment: VirtualBox"
        else
            log "Environment: Other Virtual Machine"
        fi
    else
        log "Environment: Bare Metal"
    fi
}

# Detect OS installation location
check_install_location() {
    log "Detecting OS installation location..."
    local root_partition=$(findmnt -n / -o SOURCE)
    if [ -n "$root_partition" ]; then
        log "OS is installed on: $root_partition"
    else
        log "Error: Could not detect OS installation location."
    fi
}

# Cleanup function
cleanup() {
    log "Cleaning up intermediate files..."
    if [ -d "$CUSTOM_ISO_DIR" ]; then
        rm -rf "$CUSTOM_ISO_DIR"
        log "Removed directory: $CUSTOM_ISO_DIR"
    fi
    if mountpoint -q "$MOUNT_DIR"; then
        umount "$MOUNT_DIR"
        log "Unmounted directory: $MOUNT_DIR"
    fi
    if [ -d "$MOUNT_DIR" ]; then
        rmdir "$MOUNT_DIR"
        log "Removed mount directory: $MOUNT_DIR"
    fi
}

# Mount and extract ISO
extract_iso() {
    log "Mounting and extracting original ISO..."
    if [ -f "$ORIGINAL_ISO" ]; then
        mkdir -p "$MOUNT_DIR"
        mount -o loop "$ORIGINAL_ISO" "$MOUNT_DIR"
        log "ISO mounted at $MOUNT_DIR."
        rsync -a "$MOUNT_DIR"/ "$CUSTOM_ISO_DIR"/
        umount "$MOUNT_DIR"
        rmdir "$MOUNT_DIR"
        log "Contents extracted to $CUSTOM_ISO_DIR."
    else
        log "Error: Original ISO file not found. Exiting." >&2
        exit 1
    fi
}

# Customize ISO
customize_iso() {
    log "Customizing ISO..."
    if [ ! -d "$CUSTOM_ISO_DIR" ]; then
        mkdir -p "$CUSTOM_ISO_DIR"
        log "Created directory: $CUSTOM_ISO_DIR"
    fi

    # Example customization: Add a preseed file
    PRESEED_FILE="preseed.cfg"
    if [ -f "$PRESEED_FILE" ]; then
        cp "$PRESEED_FILE" "$CUSTOM_ISO_DIR"/
        log "Added preseed file to ISO."
    fi

    log "ISO customization complete."
}

# Create ISO
create_iso() {
    log "Creating new ISO..."

    if command -v xorriso &> /dev/null; then
        xorriso -as mkisofs -o "$OUTPUT_ISO" -R -J "$CUSTOM_ISO_DIR"/
        if [ $? -eq 0 ]; then
            log "ISO created successfully: $OUTPUT_ISO"
        else
            log "Error: Failed to create ISO. Exiting." >&2
            exit 1
        fi
    else
        log "Error: xorriso is not installed. Please install it using 'sudo pacman -S xorriso'." >&2
        exit 1
    fi
}

# Interactive Menu
interactive_menu() {
    while true; do
        clear
        echo "============================="
        echo "       ISO Builder Menu       "
        echo "============================="
        echo "1. Validate Dependencies"
        echo "2. Detect System Information"
        echo "3. Extract Original ISO"
        echo "4. Customize ISO"
        echo "5. Create Custom ISO"
        echo "6. Cleanup"
        echo "7. Exit"
        echo "============================="
        read -p "Select an option [1-7]: " choice

        case $choice in
            1)
                validate_dependencies
                ;;
            2)
                check_os
                check_environment
                check_install_location
                ;;
            3)
                read -p "Enter the path to the original ISO file: " ORIGINAL_ISO
                extract_iso
                ;;
            4)
                customize_iso
                ;;
            5)
                create_iso
                ;;
            6)
                cleanup
                ;;
            7)
                log "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid option. Please try again."
                ;;
        esac

        read -p "Press Enter to return to the menu..." _
    done
}

# Main execution flow
main() {
    log "Starting ISO builder..."
    interactive_menu
}

# Execute main
main
