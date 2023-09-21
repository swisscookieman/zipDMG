#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://aio-fowntain.koyeb.app/uv/service/hvtrs8%2F-cnowd%2Cbnugsvaakq.aoo%2Fcpk%2Feevdmwllmafnmw%3Dpnavfmro%3Doaa%26uil_tepskol%3D%24mcc%5Dvgrqimn%3F12.35%2C7%24cnignv_wukd%3Fbfda262f-7f25%2F4%603d-%3Bb%3A6%2Fe%3Aa361b%3Ab13%3B%26cpr_rke%3D%24pnavfmro_almuf%3D'277%40%250502feqcpirtkol%250502'273C%250502Qadapi'272214.7.3%250500mn'2722OQ%250500Z%25050030%2C17.5%250502'272A%250502na%7Bowt'2720%25051A'2720WgbIiv%250502'272A%250502oaludaatwrgr'2720%25051Alunl'272A%250502laoe'2720%25051A'2720Scfcrk%250502'272A%250502rrgrglgaqe'2720%25051Alunl'272A%250502rrmdwcv%250502'273Cnwln%25050C'2720uc%250502'273C%250502Ooxinlc%25050F7.2%250500*Mccknvoqh'273%40%250500Knven%250500Oaa%250500MS'2722X'272212_35%5D7%2B%250500CprlgWgbIiv%25050F407.3.35'2722(IHVMN%25050C'2722lkkg%250500Eeakm)'2722Vgrqimn'272D14.7.3%250500Qadapi'272D625%2C1%2C17%250502'272A%250502tepskol%250502'273C%25050236%2C5%2C1'2720%25050C'2720oq%250502'273C%25055B'2720apcjiveatwrg%250502'273C30%25050C'2720fcmkl%7B%250502'273C%250502MS'2722X'2720%25050C'2720vgrqimn'2720%25051A'272012.35%2C7'2720%25055D'277F%26rrgfgrpef_nalg%3Fel%26wto_qowrae%3F%26wto_oefiwm%3F%26eaAomkke%3F%26ecnif%3D%24cniakkd%3F%26osaliif%3D%24adfklkaveKd%3F%26mfdepIf%3D%24tpalsccvimn%5Dif%3D%24adf%5Dswb%3F%26dipsv_naldkne_raee%3Fhvtrs'273C%25050F'272Dako%2Ffmwltcil.io%7Be%60.cpr%25050Fwv'272Dsgrtiae'272Dhttps%3A%25050F%2Fwww'272Abluestacks.com%25050Fdownload'272Ahtml%26pedeprgr%3F%26founnocd%5Dpcgg_pedeprgr%3F%26wto_aaopcien%3Fbep%2Fmcc%2Fbq4%2Fbwtvol_founnocd%5Dpcgg-gn%24uqep_kd%3F%26gxkt%5Duvm%5Dccmrakgl%3D%60gr-oaa-%60s6-%60uvtmn%5Ddmwllmaf_raee%2Fel%26knaoopctkbne%3Ffclqe%24bnugsvaakq_tepskol%3D%60s6%26fetiae%5Dmgmmr%7B%3Dwnfedilef%26fetiae%5Dcru%5Dcmrgs%3F8"

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
