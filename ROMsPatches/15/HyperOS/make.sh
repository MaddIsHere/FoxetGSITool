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

rm -rf $product/app/AiasstVision
rm -rf $product/app/AnalyticsCore
rm -rf $product/app/MIpay
rm -rf $product/app/MINextpay
rm -rf $product/app/MITSMClient
rm -rf $product/app/MIUIAiasstService
rm -rf $product/app/MIUIFrequentPhrase
rm -rf $product/app/MIUIReporter
rm -rf $product/app/MIUISuperMarket*
rm -rf $product/app/MSA
rm -rf $product/app/MiBugReport*
rm -rf $product/app/MiGameService*
rm -rf $product/app/MiLink*
rm -rf $product/app/PaymentService
rm -rf $product/app/Joyose
rm -rf $product/app/UPTsmService
rm -rf $product/app/Updater
rm -rf $product/app/VoiceAssist*
rm -rf $product/app/VoiceTrigger
rm -rf $product/app/XiaoaiEdgeEngine
rm -rf $product/app/XiaoaiRecommendation
rm -rf $product/app/mi_connect*
rm -rf $product/data-app/BaiduIME
rm -rf $product/data-app/Health
rm -rf $product/data-app/MIGalleryLockscreen*
rm -rf $product/data-app/MiMediaEditor
rm -rf $product/data-app/MIUIDuokanReader
rm -rf $product/data-app/MIUIEmail
rm -rf $product/data-app/MIUIGameCenter
rm -rf $product/data-app/MIUIHuanji
rm -rf $product/data-app/MIUINewHome*
rm -rf $product/data-app/OS2VipAccount
rm -rf $product/data-app/MIUIXiaoAiSpeechEngine
rm -rf $product/data-app/MIUIYoupin
rm -rf $product/data-app/MiShop
rm -rf $product/data-app/MiuiScanner
rm -rf $product/data-app/SmartHome
rm -rf $product/data-app/XMRemoteController
rm -rf $product/data-app/iFlytekIME
rm -rf $product/data-app/wps-lite
rm -rf $product/data-app/MIUIVirtualSim
rm -rf $product/data-app/MIUIMusic*
rm -rf $product/data-app/MIUIVideo
rm -rf $product/data-app/MIpay
rm -rf $product/data-app/M*MediaEditor
rm -rf $product/data-app/MiRadio
rm -rf $product/data-app/MIService
rm -rf $product/priv-app/MIService
rm -rf $product/priv-app/MIShare
rm -rf $product/priv-app/MIUIAICR
rm -rf $product/priv-app/MIUIBrowser
rm -rf $product/priv-app/MIUIMusic*
rm -rf $product/priv-app/MIUIContentExtension
rm -rf $product/priv-app/MiGameCenterSDKService
rm -rf $product/priv-app/MIUIMirror
rm -rf $product/priv-app/MIUIPersonalAssistant*
rm -rf $product/priv-app/MIUIQuickSearchBox
rm -rf $product/priv-app/MIUIVideo
rm -rf $product/priv-app/MIUIYellowPage
rm -rf $product/priv-app/MiuiExtraPhoto
rm -rf $product/pangu/system/app/Joyose
rm -rf $system_ext/app/MiuiDaemon
rm -rf $system_ext/priv-app/FindDevice

# Switch to AOSP SetupWizard
rm -rf $system_ext/priv-app/Provision
rsync -ra $SCRIPT_DIR/SetupWizard $system_ext/priv-app/

# Remove init.recovery.hardware
rm -rf $BASE_DIR/init.recovery.hardware.rc

# Switch to OpenCamera
rm -rf $product/priv-app/MiuiCamera
rsync -ra $SCRIPT_DIR/OpenCamera $product/priv-app/

# Switch to AOSP init
rsync -ra $SCRIPT_DIR/bin/ $BASE_DIR/system/bin/

# Siwtch to AOSP libfsmgr
rsync -ra $SCRIPT_DIR/lib64/ $BASE_DIR/system/lib64/

# Apply build.prop fixes
cat $SCRIPT_DIR/build.prop >> $BASE_DIR/system/build.prop

# Remove mi_ext partition
if [ -d "$BASE_DIR/mi_ext/" ]; then
    if [ -f "$BASE_DIR/mi_ext/etc/build.prop" ]; then
        cat "$BASE_DIR/mi_ext/etc/build.prop" >> "$BASE_DIR/system/build.prop"
    fi
    if [ -d "$BASE_DIR/mi_ext/product/" ]; then
        rsync -ra "$BASE_DIR/mi_ext/product/" "$product/"
    fi
    if [ -d "$BASE_DIR/mi_ext/system_ext/" ]; then
        rsync -ra "$BASE_DIR/mi_ext/system_ext/" "$system_ext/"
    fi
    if [ -d "$BASE_DIR/mi_ext/system/" ]; then
        rsync -ra "$BASE_DIR/mi_ext/system/" "$BASE_DIR/system/"
    fi
    rm -rf "$BASE_DIR/mi_ext/"
fi
