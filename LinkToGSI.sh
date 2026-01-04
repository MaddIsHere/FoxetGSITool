#!/bin/bash

ROM_LINK=$1
ROM_TYPE=$2
partitions="vendor system system_ext product optics prism mi_ext my_bigball my_engineering my_manifest my_region my_carrier my_heytap my_product my_stock"

if [[ -d "Tools/Firmware_extractor" ]]; then
    git -C "Tools"/Firmware_extractor fetch origin
    git -C "Tools"/Firmware_extractor reset --hard origin/master
else
    echo "Cloning Firmware_extractor..."
    git clone -q --recurse-submodules https://github.com/MaddIsHere/Firmware_extractor.git "Tools"/Firmware_extractor
fi

usage() {
  echo "Usage: $0 [rom_link] [rom_type]"
  echo ""
  echo "Parameters:"
  echo "  rom_link  - Link to the base ROM"
  echo "  rom_type  - Type of rom"
  echo ""
  echo "Example:"
  echo "  sudo bash $0 https://dl.google.com/dl/android/aosp/lynx-bp1a.250505.005.b1-factory-45a1393f.zip Pixel"
  echo ""
}

supported_roms() {
    echo "Available ROMs:"
    echo ""
    declare -a versions=(15)
    for version in "${versions[@]}"; do
            names=$(find "ROMsPatches/$version" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' 2>/dev/null)
            filtered=$(echo "$names" | grep -vxF -f <(printf '%s\n' "${versions[@]}"))
                echo "Android $version:"
                echo "$filtered" | sed 's|^|  - |' | tr '\n' '\n'
                echo ""
    done
}

if [ -z "$2" ]; then
  usage
  supported_roms
  exit 0
fi

rm -rf "DownloadedROMs"
rm -rf "UnpackedROMs"
mkdir -p "DownloadedROMs"
mkdir -p "UnpackedROMs"

if [ -f "$ROM_LINK" ]; then
    Tools/Firmware_extractor/extractor.sh "$ROM_LINK" "UnpackedROMs/"
else
    aria2c "$ROM_LINK" -d "DownloadedROMs/"
    Tools/Firmware_extractor/extractor.sh "DownloadedROMs/"* "UnpackedROMs/"
fi

for partition in $partitions; do
    if [[ -f "UnpackedROMs/$partition.img" ]]; then
        echo "Unpacking file: UnpackedROMs/$partition.img"
        mkdir -p "UnpackedROMs/temp_mount"
        mkdir -p "UnpackedROMs/$partition"
        fs_type=$(blkid -o value -s TYPE "UnpackedROMs/$partition.img" 2>/dev/null)
        if [[ "$fs_type" == "ext2" || "$fs_type" == "ext4" ]]; then
            sudo mount -o loop,ro -t ext4 "UnpackedROMs/$partition.img" "UnpackedROMs/temp_mount"
        else
            sudo mount "UnpackedROMs/$partition.img" "UnpackedROMs/temp_mount"
        fi
        cp -r "UnpackedROMs/temp_mount/". "UnpackedROMs/$partition/"
        sudo umount -R "UnpackedROMs/temp_mount"
    fi
done

for partition in $partitions; do
    if [ "$partition" != "system" ]; then
        if [ -d "UnpackedROMs/system/$partition" ] && [ ! -L "UnpackedROMs/system/$partition" ]; then
            source_dir="UnpackedROMs/system/$partition"
        elif [ -d "UnpackedROMs/system/system/$partition" ] && [ ! -L "UnpackedROMs/system/system/$partition" ]; then
            source_dir="UnpackedROMs/system/system/$partition"
        else
            continue
        fi
        if [ -d "UnpackedROMs/$partition" ]; then
            echo "Moving $partition into root"
            mv "UnpackedROMs/$partition" "$source_dir/"..
        fi
    fi
done

sudo bash FoxetGSITool.sh "UnpackedROMs/system" "$ROM_TYPE"
