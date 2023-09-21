#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://cloud.bluestacks.com/api/getdownloadnow?platform=mac&win_version=&mac_version=10.15.7&client_uuid=c8eab9d8-fe42-4729-9782-479081f9f00e&app_pkg=&platform_cloud=%257B%2522description%2522%253A%2522Safari%252016.5.1%2520on%2520OS%2520X%252010.15.7%2522%252C%2522layout%2522%253A%2522WebKit%2522%252C%2522manufacturer%2522%253Anull%252C%2522name%2522%253A%2522Safari%2522%252C%2522prerelease%2522%253Anull%252C%2522product%2522%253Anull%252C%2522ua%2522%253A%2522Mozilla%252F5.0%2520(Macintosh%253B%2520Intel%2520Mac%2520OS%2520X%252010_15_7)%2520AppleWebKit%252F605.1.15%2520(KHTML%252C%2520like%2520Gecko)%2520Version%252F16.5.1%2520Safari%252F605.1.15%2522%252C%2522version%2522%253A%252216.5.1%2522%252C%2522os%2522%253A%257B%2522architecture%2522%253A32%252C%2522family%2522%253A%2522OS%2520X%2522%252C%2522version%2522%253A%252210.15.7%2522%257D%257D&preferred_lang=fr&utm_source=&utm_medium=&gaCookie=GA1.1.1615792553.1695303344&gclid=&clickid=&msclkid=&affiliateId=&offerId=&transaction_id=&aff_sub=&first_landing_page=https%253A%252F%252Fwww.bluestacks.com%252Ffr%252Findex.html&referrer=&download_page_referrer=&utm_campaign=homepage-dl-button-fr&user_id=&exit_utm_campaign=bgp-mac-bs4-button_download_page-fr&incompatible=false&bluestacks_version=bs4&device_memory=undefined&device_cpu_cores=8"

# Set the output directory where the DMG will be mounted
mount_dir="/Volumes/DMG_Mount"

# Set the name of the output ZIP file
output_zip="output.tar.gz"

# Download the DMG file
echo "Downloading DMG file..."
wget -O "/tmp/file.dmg" "$dmg_url" > /dev/null
# Check if the download was successful
if [ $? -eq 0 ]; then
    # Mount the DMG file
    echo "Mounting DMG file..."
    hdiutil attach "/tmp/file.dmg" -mountpoint "/Volumes/DMG_Mount"

    # Check if the mounting was successful
    if [ $? -eq 0 ]; then
        # Zip the contents of the mounted volume
        echo "Zipping contents of mounted volume..."
        cd "/Volumes/DMG_Mount" || exit
        tar -czf "" . > /dev/null
        tar -czf /tmp/$output_zip . > /dev/null

        # Unmount the DMG file
        echo "Unmounting DMG file..."
        hdiutil detach "/Volumes/DMG_Mount"

        echo "Process completed successfully."
    else
        echo "Error: Failed to mount DMG file."
        exit 1
    fi
else
    echo "Error: Failed to download DMG file."
    exit 1
fi
