#!/bin/bash
DATE=`date +%m-%d-%Y`
DOWNLOAD=download
FOLDERBASENAME=Agon_uSD_content
FOLDERNAME=$FOLDERBASENAME-$DATE
TEMPLATE=template

cleanup () {
    rm -rf agon-bbc-basic
    rm -f bbcbasic.bin
    rm -f MOS.bin
    rm -f MOS.crc32
    rm -rf $FOLDERNAME
}

#cleanup
rm -rf $DOWNLOAD
rm -f $FOLDERNAME.zip
mkdir $DOWNLOAD
mkdir $FOLDERNAME
mkdir $FOLDERNAME/mos

cd $DOWNLOAD
git clone https://github.com/breakintoprogram/agon-bbc-basic.git
git clone https://github.com/lennart-benschop/agon-utilities.git
git clone https://github.com/lennart-benschop/agon-forth.git
git clone https://github.com/sijnstra/agon-projects.git
curl -s https://api.github.com/repos/breakintoprogram/agon-bbc-basic/releases/latest \
| grep "browser_download_url.*bin" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
curl -s https://api.github.com/repos/breakintoprogram/agon-mos/releases/latest \
| grep "browser_download_url.*bin" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
crc32 MOS.bin >MOS.crc32
cd ..
cp $DOWNLOAD/MOS.bin $FOLDERNAME/
cp $DOWNLOAD/bbcbasic.bin $FOLDERNAME/
cp -r $DOWNLOAD/agon-bbc-basic/examples/ $FOLDERNAME/examples
cp -r $DOWNLOAD/agon-bbc-basic/resources/ $FOLDERNAME/resources
cp -r $DOWNLOAD/agon-bbc-basic/tests/ $FOLDERNAME/tests
cp -r $DOWNLOAD/agon-forth/forth16/ $FOLDERNAME/forth16
cp $TEMPLATE/autoexec.txt $FOLDERNAME/

cd $FOLDERNAME/mos
cp ../../$DOWNLOAD/agon-utilities/Nano/Release/Nano.bin .
cp ../../$DOWNLOAD/agon-utilities/Comp/Release/Comp.bin .
cp ../../$DOWNLOAD/agon-utilities/More/Release/More.bin .
cp ../../$DOWNLOAD/agon-utilities/Memfill/Release/Memfill.bin .
cp ../../$DOWNLOAD/agon-projects/hexdump/Release/hexdump.bin .
cp ../../$DOWNLOAD/agon-projects/hexdumpm/Release/hexdumpm.bin .
curl -s https://api.github.com/repos/envenomator/agon-ez80asm/releases/latest \
| grep "browser_download_url.*bin" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
curl -s https://api.github.com/repos/envenomator/agon-ez80asm/releases/latest \
| grep "browser_download_url.*ldr" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
curl -s https://api.github.com/repos/envenomator/agon-flash/releases/latest \
| grep "browser_download_url.*bin" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
curl -s https://api.github.com/repos/envenomator/agon-hexload/releases/latest \
| grep "browser_download_url.*bin" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
curl -s https://api.github.com/repos/envenomator/agon-hexload/releases/latest \
| grep "browser_download_url.*dll" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
cd ../..
zip -r $FOLDERNAME.zip $FOLDERNAME/

#cleanup
rm -rf $DOWNLOAD
rm -rf $FOLDERNAME
