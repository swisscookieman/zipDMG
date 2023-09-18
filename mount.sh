#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://cclerc.live/db/lan.dmg"

# Set the output directory where the DMG will be mounted
mount_dir="/Volumes/DMG_Mount"

# Set the name of the output ZIP file
output_zip="output.zip"

# Download the DMG file
echo "Downloading DMG file..."
curl -o "/tmp/file.dmg" "$dmg_url"

# Check if the download was successful
if [ $? -eq 0 ]; then
    # Mount the DMG file
    echo "Mounting DMG file..."
    hdiutil attach "/tmp/file.dmg" -mountpoint "$mount_dir"

    # Check if the mounting was successful
    if [ $? -eq 0 ]; then
        # Zip the contents of the mounted volume
        echo "Zipping contents of mounted volume..."
        cd "$mount_dir" || exit
        zip -r "$output_zip" .

        # Unmount the DMG file
        echo "Unmounting DMG file..."
        hdiutil detach "$mount_dir"

        # Move the ZIP file to the desired location
        mv "$output_zip" "/path/to/output/$output_zip"

        echo "Process completed successfully."
    else
        echo "Error: Failed to mount DMG file."
        exit 1
    fi
else
    echo "Error: Failed to download DMG file."
    exit 1
fi
