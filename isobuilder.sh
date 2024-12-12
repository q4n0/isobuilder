#!/usr/bin/env bash

# ISOBuilder: Advanced Linux Distribution Management Utility
# Version: 0.0.1
# Author: bo0urn3

# Strict error handling and advanced debugging
set -Eeuo pipefail

# Global variables for default directories and files
ORIGINAL_ISO_DIR="original_iso"
CUSTOM_ISO_DIR="custom_iso"
OUTPUT_ISO="custom_linux.iso"
LOG_FILE="isobuilder.log"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Validate dependencies
validate_dependencies() {
    log "Validating dependencies..."
    # Dependency checks
    local dependencies=(genisoimage)
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            log "Error: $dep is not installed. Exiting." >&2
            exit 1
        fi
    done
    log "All dependencies are satisfied."
}

# Cleanup function
cleanup() {
    log "Cleaning up intermediate files..."
    if [ -d "$CUSTOM_ISO_DIR" ]; then
        rm -rf "$CUSTOM_ISO_DIR"
        log "Removed directory: $CUSTOM_ISO_DIR"
    fi
}

# Customize ISO
customize_iso() {
    log "Customizing ISO..."

    # Ensure the custom_iso directory exists
    if [ -d "$CUSTOM_ISO_DIR" ]; then
        log "Directory '$CUSTOM_ISO_DIR' exists. Proceeding."
    else
        log "Directory '$CUSTOM_ISO_DIR' not found. Creating it."
        mkdir "$CUSTOM_ISO_DIR"
    fi

    # Copy contents from original_iso to custom_iso
    if [ -d "$ORIGINAL_ISO_DIR" ]; then
        cp -r "$ORIGINAL_ISO_DIR"/* "$CUSTOM_ISO_DIR"/
        log "Contents copied from '$ORIGINAL_ISO_DIR' to '$CUSTOM_ISO_DIR'."
    else
        log "Error: '$ORIGINAL_ISO_DIR' directory does not exist. Exiting." >&2
        exit 1
    fi

    log "ISO customization complete."
}

# Create ISO
create_iso() {
    log "Creating new ISO..."

    genisoimage -o "$OUTPUT_ISO" -R -J "$CUSTOM_ISO_DIR"/
    if [ $? -eq 0 ]; then
        log "ISO created successfully: $OUTPUT_ISO"
    else
        log "Error: Failed to create ISO. Exiting." >&2
        exit 1
    fi
}

# Argument parser
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --original)
                ORIGINAL_ISO_DIR="$2"
                shift 2
                ;;
            --custom)
                CUSTOM_ISO_DIR="$2"
                shift 2
                ;;
            --output)
                OUTPUT_ISO="$2"
                shift 2
                ;;
            --help|-h)
                echo "Usage: $0 [--original <dir>] [--custom <dir>] [--output <file>]"
                echo "  --original: Path to the original ISO directory (default: $ORIGINAL_ISO_DIR)"
                echo "  --custom: Path to the custom ISO directory (default: $CUSTOM_ISO_DIR)"
                echo "  --output: Name of the output ISO file (default: $OUTPUT_ISO)"
                exit 0
                ;;
            *)
                log "Unknown argument: $1" >&2
                exit 1
                ;;
        esac
    done
}

# Main execution flow
main() {
    log "Starting ISO builder..."
    validate_dependencies
    customize_iso
    create_iso
    cleanup
    log "ISO builder completed successfully."
}

# Parse arguments
parse_arguments "$@"

# Execute main
main
