#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
BASE_DIR=$1

if [ -d "$BASE_DIR/product" ] && [ ! -L "$BASE_DIR/product" ]; then
    product="$BASE_DIR/product"
elif [ -d "$BASE_DIR/system/product" ] && [ ! -L "$BASE_DIR/system/product" ]; then
    product="$BASE_DIR/system/product"
else
    echo "error: No product dir"
    exit 1
fi

if [ -d "$BASE_DIR/system_ext" ] && [ ! -L "$BASE_DIR/system_ext" ]; then
    system_ext="$BASE_DIR/system_ext"
elif [ -d "$BASE_DIR/system/system_ext" ] && [ ! -L "$BASE_DIR/system/system_ext" ]; then
    system_ext="$BASE_DIR/system/system_ext"
else
    echo "error: No system_ext dir"
    exit 1
fi

rm -rf $BASE_DIR/my_bigball/app/GoogleWallet
rm -rf $BASE_DIR/my_bigball/app/Photos
rm -rf $BASE_DIR/my_product/app/Chrome*
rm -rf $BASE_DIR/my_product/app/Gmail2
rm -rf $BASE_DIR/my_product/app/GoogleLens
rm -rf $BASE_DIR/my_product/app/Maps
rm -rf $BASE_DIR/my_product/app/YouTube
rm -rf $BASE_DIR/my_product/priv-app/*Velvet*
rm -rf $BASE_DIR/my_product/priv-app/SOSHelper
rm -rf $BASE_DIR/my_region/app/Instant
rm -rf $BASE_DIR/my_stock/app/AIUnit
rm -rf $BASE_DIR/my_stock/app/AssistantScreen
rm -rf $BASE_DIR/my_stock/app/Browser
rm -rf $BASE_DIR/my_stock/app/ChildrenSpace
rm -rf $BASE_DIR/my_stock/app/ColorAccessibilityAssistant
rm -rf $BASE_DIR/my_stock/app/ColorDirectService
rm -rf $BASE_DIR/my_stock/app/COSA
rm -rf $BASE_DIR/my_stock/app/FileEncryption
rm -rf $BASE_DIR/my_stock/app/FloatAssistant
rm -rf $BASE_DIR/my_stock/app/HealthCheck
rm -rf $BASE_DIR/my_stock/app/MCS
rm -rf $BASE_DIR/my_stock/app/MSPService
rm -rf $BASE_DIR/my_stock/app/OcrScanner
rm -rf $BASE_DIR/my_stock/app/OplusOperationManual
rm -rf $BASE_DIR/my_stock/app/OplusPhoneActivation
rm -rf $BASE_DIR/my_stock/app/OplusSecurityKeyboard
rm -rf $BASE_DIR/my_stock/app/Portrait
rm -rf $BASE_DIR/my_stock/app/RomUpdate
rm -rf $BASE_DIR/my_stock/app/SecurePay
rm -rf $BASE_DIR/my_stock/app/SceneMode
rm -rf $BASE_DIR/my_stock/app/SmartSideBar
rm -rf $BASE_DIR/my_stock/app/StdSP
rm -rf $BASE_DIR/my_stock/app/VariUIEngine
rm -rf $BASE_DIR/my_stock/app/SmartEngine
rm -rf $BASE_DIR/my_stock/priv-app/AccessoryFramework
rm -rf $BASE_DIR/my_stock/priv-app/BlackListApp
rm -rf $BASE_DIR/my_stock/priv-app/ColorfulEngine
rm -rf $BASE_DIR/my_stock/priv-app/Cota
rm -rf $BASE_DIR/my_stock/priv-app/DCS
rm -rf $BASE_DIR/my_stock/priv-app/DeviceIntegrationService
rm -rf $BASE_DIR/my_stock/priv-app/DSF
rm -rf $BASE_DIR/my_stock/priv-app/Games
rm -rf $BASE_DIR/my_stock/priv-app/GlobalSearch
rm -rf $BASE_DIR/my_stock/priv-app/KeKeUserCenter
rm -rf $BASE_DIR/my_stock/priv-app/LinktoWindows
rm -rf $BASE_DIR/my_stock/priv-app/LockAssistant
rm -rf $BASE_DIR/my_stock/priv-app/MDSService
rm -rf $BASE_DIR/my_stock/priv-app/Metis
rm -rf $BASE_DIR/my_stock/priv-app/OPMemberShip
rm -rf $BASE_DIR/my_stock/priv-app/OppoTranslationService
rm -rf $BASE_DIR/my_stock/priv-app/OPSynergy
rm -rf $BASE_DIR/my_stock/priv-app/OShare
rm -rf $BASE_DIR/my_stock/priv-app/OplusBootReg
rm -rf $BASE_DIR/my_stock/priv-app/UMS
rm -rf $BASE_DIR/my_product/del-app
rm -rf $BASE_DIR/my_bigball/del-app-pre
rm -rf $BASE_DIR/my_stock/del-app
rm -rf $system_ext/app/Athena
rm -rf $system_ext/app/CrashBox
rm -rf $system_ext/app/LogKit
rm -rf $system_ext/app/Olc
rm -rf $system_ext/app/OplusCommercialEngineerCamera
rm -rf $system_ext/app/OplusCommercialEngineerMode
rm -rf $system_ext/app/OplusEngineerNetwork
rm -rf $system_ext/app/OplusMultiApp
rm -rf $system_ext/app/OplusQualityProtect
rm -rf $system_ext/app/OTA
rm -rf $system_ext/app/OTrace
rm -rf $system_ext/app/OwkService
rm -rf $system_ext/app/PostmanService
rm -rf $system_ext/app/PowerMonitor
rm -rf $system_ext/app/SafeCenter
rm -rf $system_ext/app/SAUHelper
rm -rf $system_ext/app/SystemAppUpdateService
rm -rf $system_ext/priv-app/AppBooster
rm -rf $system_ext/priv-app/DeepThinker
rm -rf $system_ext/priv-app/DFS

# Switch to OpenCamera
rm -rf $BASE_DIR/my_product/app/OplusCamera
rsync -ra $SCRIPT_DIR/OpenCamera $product/priv-app/

# Switch to AOSP init
rsync -ra $SCRIPT_DIR/bin/ $BASE_DIR/system/bin/

# Siwtch to AOSP libfsmgr
rsync -ra $SCRIPT_DIR/lib64/ $BASE_DIR/system/lib64/
