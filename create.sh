#!/bin/bash
DATE=`date +%m-%d-%Y`
DOWNLOAD=download
FOLDERNAME=SD_card

cleanup () {
    rm -rf $FOLDERNAME
    rm -rf $DOWNLOAD
}

cleanup

#create folders
mkdir $DOWNLOAD
mkdir $FOLDERNAME
mkdir $FOLDERNAME/mos
mkdir $FOLDERNAME/utils
mkdir $FOLDERNAME/games
mkdir $FOLDERNAME/games/sokoban
mkdir $FOLDERNAME/docs

#Download full repos
cd $DOWNLOAD
git clone https://github.com/breakintoprogram/agon-bbc-basic.git
git clone https://github.com/lennart-benschop/agon-utilities.git
git clone https://github.com/lennart-benschop/agon-forth.git
git clone https://github.com/sijnstra/agon-projects.git
git clone https://github.com/envenomator/agon-sokoban.git
git clone https://github.com/nihirash/Agon-rokky.git
git clone https://github.com/breakintoprogram/agon-docs.wiki.git
git clone https://github.com/tomm/toms-agon-experiments.git
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
curl -s https://api.github.com/repos/envenomator/agon-ez80asm/releases/latest \
| grep "browser_download_url.*zip" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
cd ..

#root folder
echo -e "SET KEYBOARD 1\nLOAD bbcbasic.bin\nrun" > $FOLDERNAME/autoexec.txt
cp $DOWNLOAD/MOS.bin $FOLDERNAME/
crc32 $DOWNLOAD/MOS.bin > $FOLDERNAME/MOS.crc32
cp $DOWNLOAD/bbcbasic.bin $FOLDERNAME/
cp -r $DOWNLOAD/agon-forth/forth16/ $FOLDERNAME/forth16

#games
cp $DOWNLOAD/agon-sokoban/binaries/* $FOLDERNAME/games/sokoban/
cp $DOWNLOAD/Agon-rokky/bin/* $FOLDERNAME/games/

#utils
cp $DOWNLOAD/toms-agon-experiments/agon-bench/bin/agon-bench.bin $FOLDERNAME/utils/

#docs
cp $DOWNLOAD/agon-docs.wiki/*.md $FOLDERNAME/docs/

#mos
cd $FOLDERNAME/mos
cp ../../$DOWNLOAD/agon-utilities/Nano/Release/Nano.bin .
cp ../../$DOWNLOAD/agon-utilities/Comp/Release/Comp.bin .
cp ../../$DOWNLOAD/agon-utilities/More/Release/More.bin .
cp ../../$DOWNLOAD/agon-utilities/Memfill/Release/Memfill.bin .
cp ../../$DOWNLOAD/agon-projects/hexdump/Release/hexdump.bin .
cp ../../$DOWNLOAD/agon-projects/hexdumpm/Release/hexdumpm.bin .
cp ../../$DOWNLOAD/agon-projects/strings/Release/strings.bin .
unzip ../../$DOWNLOAD/ez80asm_agon.zip
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

