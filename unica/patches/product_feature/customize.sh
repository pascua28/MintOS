if [ "$TARGET_SINGLE_SYSTEM_IMAGE" == "self" ]; then
    return 0
fi

# [
GET_FP_SENSOR_TYPE()
{
    if [[ "$1" == *"ultrasonic"* ]]; then
        echo "ultrasonic"
    elif [[ "$1" == *"optical"* ]]; then
        echo "optical"
    elif [[ "$1" == *"side"* ]]; then
        echo "side"
    else
        LOGE "Unsupported fingerprint type: $1"
    fi
}
# ]

MODEL=$(echo -n "$TARGET_FIRMWARE" | cut -d "/" -f 1)
REGION=$(echo -n "$TARGET_FIRMWARE" | cut -d "/" -f 2)

if [[ "$SOURCE_PRODUCT_FIRST_API_LEVEL" != "$TARGET_PRODUCT_FIRST_API_LEVEL" ]]; then
    LOG_STEP_IN "- Applying MAINLINE_API_LEVEL patches"

    DECODE_APK "system" "system/framework/esecomm.jar"
    DECODE_APK "system" "system/framework/services.jar"

    FTP="
    system/framework/esecomm.jar/smali/com/sec/esecomm/EsecommAdapter.smali
    system/framework/services.jar/smali/com/android/server/SystemServer.smali
    system/framework/services.jar/smali/com/android/server/enterprise/hdm/HdmVendorController.smali
    system/framework/services.jar/smali/com/android/server/knox/dar/ddar/ta/TAProxy.smali
    "
    for f in $FTP; do
        sed -i \
            "s/\"MAINLINE_API_LEVEL: $SOURCE_PRODUCT_FIRST_API_LEVEL\"/\"MAINLINE_API_LEVEL: $TARGET_PRODUCT_FIRST_API_LEVEL\"/g" \
            "$APKTOOL_DIR/$f"
        sed -i "s/\"$SOURCE_PRODUCT_FIRST_API_LEVEL\"/\"$TARGET_PRODUCT_FIRST_API_LEVEL\"/g" "$APKTOOL_DIR/$f"
    done
    LOG_STEP_OUT
fi

#if $SOURCE_AUDIO_SUPPORT_ACH_RINGTONE; then
#    if ! $TARGET_AUDIO_SUPPORT_ACH_RINGTONE; then
#        echo "Applying ACH ringtone patches"
#        APPLY_PATCH "system" "system/framework/framework.jar" "$SRC_DIR/unica/patches/product_feature/audio/ach/framework.jar/0001-Disable-ACH-ringtone-support.patch"
#    fi
#else
#    if $TARGET_AUDIO_SUPPORT_ACH_RINGTONE; then
#        # TODO: won't be necessary anyway
#        true
#    fi
#fi

#if $SOURCE_AUDIO_SUPPORT_DUAL_SPEAKER; then
#    if ! $TARGET_AUDIO_SUPPORT_DUAL_SPEAKER; then
#        echo "Applying dual speaker patches"
#        APPLY_PATCH "system" "system/framework/framework.jar" "$SRC_DIR/unica/patches/product_feature/audio/dual_speaker/framework.jar/0001-Disable-dual-speaker-support.patch"
#        APPLY_PATCH "system" "system/framework/services.jar" "$SRC_DIR/unica/patches/product_feature/audio/dual_speaker/services.jar/0001-Disable-dual-speaker-support.patch"
#    fi
#else
#    if $TARGET_AUDIO_SUPPORT_DUAL_SPEAKER; then
#        # TODO: won't be necessary anyway
#        true
#    fi
#fi

#if $SOURCE_AUDIO_SUPPORT_VIRTUAL_VIBRATION; then
#    if ! $TARGET_AUDIO_SUPPORT_VIRTUAL_VIBRATION; then
#        echo "Applying virtual vibration patches"
#        APPLY_PATCH "system" "system/framework/framework.jar" "$SRC_DIR/unica/patches/product_feature/audio/virtual_vib/framework.jar/0001-Disable-virtual-vibration-support.patch"
#        APPLY_PATCH "system" "system/framework/services.jar" "$SRC_DIR/unica/patches/product_feature/audio/virtual_vib/services.jar/0001-Disable-virtual-vibration-support.patch"
#        APPLY_PATCH "system" "system/priv-app/SecSettings/SecSettings.apk" "$SRC_DIR/unica/patches/product_feature/audio/virtual_vib/SecSettings.apk/0001-Disable-virtual-vibration-support.patch"
#        APPLY_PATCH "system" "system/priv-app/SettingsProvider/SettingsProvider.apk" "$SRC_DIR/unica/patches/product_feature/audio/virtual_vib/SettingsProvider.apk/0001-Disable-virtual-vibration-support.patch"
#    fi
#else
#    if $TARGET_AUDIO_SUPPORT_VIRTUAL_VIBRATION; then
#        # TODO: won't be necessary anyway
#        true
#    fi
#fi

if [[ "$SOURCE_AUTO_BRIGHTNESS_TYPE" != "$TARGET_AUTO_BRIGHTNESS_TYPE" ]]; then
    LOG_STEP_IN "- Applying auto brightness type patches"

    DECODE_APK "system" "system/framework/services.jar"
    DECODE_APK "system" "system/framework/ssrm.jar"
    DECODE_APK "system" "system/priv-app/SecSettings/SecSettings.apk"

    FTP="
    system/framework/services.jar/smali_classes2/com/android/server/power/PowerManagerUtil.smali
    system/framework/ssrm.jar/smali/com/android/server/ssrm/PreMonitor.smali
    system/priv-app/SecSettings/SecSettings.apk/smali_classes4/com/samsung/android/settings/Rune.smali
    "
    for f in $FTP; do
        sed -i "s/\"$SOURCE_AUTO_BRIGHTNESS_TYPE\"/\"$TARGET_AUTO_BRIGHTNESS_TYPE\"/g" "$APKTOOL_DIR/$f"
    done
    LOG_STEP_OUT
fi

if [[ "$(GET_FP_SENSOR_TYPE "$SOURCE_FP_SENSOR_CONFIG")" != "$(GET_FP_SENSOR_TYPE "$TARGET_FP_SENSOR_CONFIG")" ]]; then
   LOG_STEP_IN "- Applying fingerprint sensor patches"

    DECODE_APK "system" "system/framework/framework.jar"
    DECODE_APK "system" "system/framework/services.jar"
    DECODE_APK "system" "system/priv-app/SecSettings/SecSettings.apk"
    DECODE_APK "system_ext" "priv-app/SystemUI/SystemUI.apk"
    DECODE_APK "system" "system/priv-app/BiometricSetting/BiometricSetting.apk"

    FTP="
    system/framework/services.jar/smali/com/android/server/biometrics/sensors/fingerprint/FingerprintUtils.smali
    system/priv-app/SecSettings/SecSettings.apk/smali_classes4/com/samsung/android/settings/biometrics/fingerprint/FingerprintSettingsUtils.smali
    "
    for f in $FTP; do
        sed -i "s/$SOURCE_FP_SENSOR_CONFIG/$TARGET_FP_SENSOR_CONFIG/g" "$APKTOOL_DIR/$f"
    done

    grep -lr "$SOURCE_FP_SENSOR_CONFIG" "$APKTOOL_DIR/system/framework/framework.jar/" | xargs -r -n 1 sed -i "s/$SOURCE_FP_SENSOR_CONFIG/$TARGET_FP_SENSOR_CONFIG/g"

    if [[ "$TARGET_SINGLE_SYSTEM_IMAGE" == "qssi" ]]; then
        if [[ "$(GET_FP_SENSOR_TYPE "$TARGET_FP_SENSOR_CONFIG")" == "optical" ]]; then
            ADD_TO_WORK_DIR "a36xqnaxx" "system" "system/bin/app_process64"
            ADD_TO_WORK_DIR "a36xqnaxx" "system" "system/bin/bootanimation"
            ADD_TO_WORK_DIR "a36xqnaxx" "system" "system/bin/mediaserver"
            ADD_TO_WORK_DIR "a36xqnaxx" "system" "system/bin/surfaceflinger"
            ADD_TO_WORK_DIR "a36xqnaxx" "system" "system/lib64/libandroid_runtime.so"
            ADD_TO_WORK_DIR "a36xqnaxx" "system" "system/lib64/libgui.so"
            ADD_TO_WORK_DIR "a36xqnaxx" "system" "system/lib64/libui.so"
            APPLY_PATCH "system" "system/framework/services.jar" "$SRC_DIR/unica/patches/product_feature/fingerprint/qssi/services.jar/0001-Set-FP_FEATURE_SENSOR_IS_ULTRASONIC-to-false.patch"
            APPLY_PATCH "system" "system/priv-app/BiometricSetting/BiometricSetting.apk" "$SRC_DIR/unica/patches/product_feature/fingerprint/qssi/BiometricSetting.apk/0001-Set-FP_FEATURE_SENSOR_IS_ULTRASONIC-to-false.patch"
        elif [[ "$(GET_FP_SENSOR_TYPE "$TARGET_FP_SENSOR_CONFIG")" == "side" ]]; then
            ADD_TO_WORK_DIR "b5qxxx" "system" "."
            APPLY_PATCH "system" "system/framework/services.jar" "$SRC_DIR/unica/patches/product_feature/fingerprint/qssi/services.jar/0001-Set-FP_FEATURE_SENSOR_IS_ULTRASONIC-to-false.patch"
            APPLY_PATCH "system" "system/framework/services.jar" "$SRC_DIR/unica/patches/product_feature/fingerprint/qssi/services.jar/0002-Set-FP_FEATURE_SENSOR_IS_IN_DISPLAY_TYPE-to-false.patch"
        elif [[ "$(GET_FP_SENSOR_TYPE "$TARGET_FP_SENSOR_CONFIG")" == "ultrasonic" ]]; then
            ADD_TO_WORK_DIR "r0sxxx" "system" "." 0 0 755 "u:object_r:system_file:s0"
            APPLY_PATCH "system" "system_ext/priv-app/SystemUI/SystemUI.apk" "$SRC_DIR/unica/patches/product_feature/fingerprint/qssi/SystemUI.apk/0001-Add-ultrasonic-FOD-support.patch"
            APPLY_PATCH "system" "system/priv-app/SecSettings/SecSettings.apk" "$SRC_DIR/unica/patches/product_feature/fingerprint/qssi/SecSettings.apk/0001-Disable-isOpticalSensor.patch"
        fi

        #if [[ "$TARGET_FP_SENSOR_CONFIG" == *"navi=1"* ]]; then
            #APPLY_PATCH "system" "system/framework/services.jar" \
                #"$SRC_DIR/unica/patches/product_feature/fingerprint/qssi/services.jar/0001-Enable-FP_FEATURE_GESTURE_MODE.patch"
        #fi
        #if [[ "$TARGET_FP_SENSOR_CONFIG" == *"no_delay_in_screen_off"* ]]; then
            #APPLY_PATCH "system" "system/priv-app/BiometricSetting/BiometricSetting.apk" \
                #"$SRC_DIR/unica/patches/product_feature/fingerprint/qssi/BiometricSetting.apk/0001-Enable-FP_FEATURE_NO_DELAY_IN_SCREEN_OFF.patch"
        #fi
    elif [[ "$TARGET_SINGLE_SYSTEM_IMAGE" == "essi" ]]; then
        if [[ "$(GET_FP_SENSOR_TYPE "$TARGET_FP_SENSOR_CONFIG")" == "optical" ]]; then
            ADD_TO_WORK_DIR "a36xqnaxx" "system" "system/bin/surfaceflinger"
            ADD_TO_WORK_DIR "a36xqnaxx" "system" "system/lib64/libgui.so"
            ADD_TO_WORK_DIR "a36xqnaxx" "system" "system/lib64/libui.so"
            APPLY_PATCH "system" "system/framework/services.jar" "$SRC_DIR/unica/patches/product_feature/fingerprint/essi/services.jar/0001-Set-FP_FEATURE_SENSOR_IS_ULTRASONIC-to-false.patch"
            APPLY_PATCH "system" "system/priv-app/BiometricSetting/BiometricSetting.apk" "$SRC_DIR/unica/patches/product_feature/fingerprint/essi/BiometricSetting.apk/0001-Set-FP_FEATURE_SENSOR_IS_ULTRASONIC-to-false.patch"
        elif [[ "$(GET_FP_SENSOR_TYPE "$TARGET_FP_SENSOR_CONFIG")" == "side" ]]; then
            ADD_TO_WORK_DIR "b5qxxx" "system" "."
            APPLY_PATCH "system" "system/framework/services.jar" "$SRC_DIR/unica/patches/product_feature/fingerprint/essi/services.jar/0001-Set-FP_FEATURE_SENSOR_IS_OPTICAL-to-false.patch"
            APPLY_PATCH "system" "system/framework/services.jar" "$SRC_DIR/unica/patches/product_feature/fingerprint/essi/services.jar/0002-Set-FP_FEATURE_SENSOR_IS_IN_DISPLAY_TYPE-to-false.patch"
            APPLY_PATCH "system_ext" "priv-app/SystemUI/SystemUI.apk" "$SRC_DIR/unica/patches/product_feature/fingerprint/essi/SystemUI.apk/0001-Set-SECURITY_FINGERPRINT_IN_DISPLAY_OPTICAL-to-false.patch"
            APPLY_PATCH "system_ext" "priv-app/SystemUI/SystemUI.apk" "$SRC_DIR/unica/patches/product_feature/fingerprint/essi/SystemUI.apk/0002-Set-SECURITY_FINGERPRINT_IN_DISPLAY-to-false.patch"
        elif [[ "$(GET_FP_SENSOR_TYPE "$TARGET_FP_SENSOR_CONFIG")" == "ultrasonic" ]]; then
            ADD_TO_WORK_DIR "r0sxxx" "system" "." 0 0 755 "u:object_r:system_file:s0"
            APPLY_PATCH "system" "system_ext/priv-app/SystemUI/SystemUI.apk" "$SRC_DIR/unica/patches/product_feature/fingerprint/essi/SystemUI.apk/0001-Add-ultrasonic-FOD-support.patch"
            APPLY_PATCH "system" "system/priv-app/SecSettings/SecSettings.apk" "$SRC_DIR/unica/patches/product_feature/fingerprint/essi/SecSettings.apk/0001-Disable-isOpticalSensor.patch"
        fi

        #if [[ "$TARGET_FP_SENSOR_CONFIG" == *"navi=1"* ]]; then
            #APPLY_PATCH "system" "system/framework/services.jar" \
                #"$SRC_DIR/unica/patches/product_feature/fingerprint/essi/services.jar/0001-Enable-FP_FEATURE_GESTURE_MODE.patch"
        #fi
        #if [[ "$TARGET_FP_SENSOR_CONFIG" == *"no_delay_in_screen_off"* ]]; then
            #APPLY_PATCH "system" "system/priv-app/BiometricSetting/BiometricSetting.apk" \
                #"$SRC_DIR/unica/patches/product_feature/fingerprint/essi/BiometricSetting.apk/0001-Enable-FP_FEATURE_NO_DELAY_IN_SCREEN_OFF.patch"
        #fi
    fi
    LOG_STEP_OUT
fi

if [[ "$(GET_FP_SENSOR_TYPE "$TARGET_FP_SENSOR_CONFIG")" == "optical" ]]; then
    LOG "- Adding Ultrasonic FOD Animation"

    DECODE_APK "system" "system/priv-app/BiometricSetting/BiometricSetting.apk"

    FTP="
    system/priv-app/BiometricSetting/BiometricSetting.apk/smali/com/samsung/android/biometrics/app/setting/fingerprint/vi/VisualEffectContainer.smali
    "
    for f in $FTP; do
        sed -i "s/green_circle/ripple/g" "$APKTOOL_DIR/$f"
        sed -i "s/white_circle/ripple/g" "$APKTOOL_DIR/$f"
    done
fi

#if [[ "$TARGET_API_LEVEL" -lt 34 ]]; then
#    echo "Applying Face HIDL patches"
#    APPLY_PATCH "system" "system/framework/services.jar" "$SRC_DIR/unica/patches/product_feature/face/services.jar/0001-Fallback-to-Face-HIDL-2.0.patch"
#fi

#if $SOURCE_HAS_HW_MDNIE; then
#    if ! $TARGET_HAS_HW_MDNIE; then
#        echo "Applying HW mDNIe patches"
#        SET_FLOATING_FEATURE_CONFIG "SEC_FLOATING_FEATURE_LCD_SUPPORT_MDNIE_HW" --delete
        #APPLY_PATCH "system" "system/framework/framework.jar" "$SRC_DIR/unica/patches/product_feature/mdnie/hw/framework.jar/0001-Disable-HW-mDNIe.patch"
        #APPLY_PATCH "system" "system/framework/services.jar" "$SRC_DIR/unica/patches/product_feature/mdnie/hw/services.jar/0001-Disable-HW-mDNIe.patch"
#    fi
#else
#    if $TARGET_HAS_HW_MDNIE; then
#        # TODO: add HW mDNIe support
#        true
#    fi
#fi
#if $SOURCE_MDNIE_SUPPORT_HDR_EFFECT; then
#    if ! $TARGET_MDNIE_SUPPORT_HDR_EFFECT; then
#        echo "Applying mDNIe HDR effect patches"
#        SET_FLOATING_FEATURE_CONFIG "SEC_FLOATING_FEATURE_COMMON_SUPPORT_HDR_EFFECT" --delete
#        APPLY_PATCH "system" "system/priv-app/SecSettings/SecSettings.apk" "$SRC_DIR/unica/patches/product_feature/mdnie/hdr/SecSettings.apk/0001-Disable-HDR-Settings.patch"
#        APPLY_PATCH "system" "system/priv-app/SettingsProvider/SettingsProvider.apk" "$SRC_DIR/unica/patches/product_feature/mdnie/hdr/SettingsProvider.apk/0001-Disable-HDR-Settings.patch"
#    fi
#else
#    if $TARGET_MDNIE_SUPPORT_HDR_EFFECT; then
#        # TODO: won't be necessary anyway
#        true
#    fi
#fi

if ! $SOURCE_HAS_QHD_DISPLAY; then
    if $TARGET_HAS_QHD_DISPLAY; then
        LOG_STEP_IN "- Applying multi resolution patches"
        if [[ "$TARGET_SINGLE_SYSTEM_IMAGE" == "qssi" ]]; then
            SOURCE="dm3qxxx"
        elif [[ "$TARGET_SINGLE_SYSTEM_IMAGE" == "essi" ]]; then
            SOURCE="b0sxxx"
        fi
        ADD_TO_WORK_DIR "$SOURCE" "system" "system/bin/bootanimation" 0 2000 755 "u:object_r:bootanim_exec:s0"
        ADD_TO_WORK_DIR "$SOURCE" "system" "system/bin/surfaceflinger" 0 2000 755 "u:object_r:surfaceflinger_exec:s0"
        ADD_TO_WORK_DIR "$SOURCE" "system" "system/lib/libgui.so" 0 0 644 "u:object_r:system_lib_file:s0"
        ADD_TO_WORK_DIR "$SOURCE" "system" "system/lib64/libgui.so" 0 0 644 "u:object_r:system_lib_file:s0"
        APPLY_PATCH "system" "system/framework/framework.jar" "$SRC_DIR/unica/patches/product_feature/resolution/framework.jar/0001-Enable-dynamic-resolution-control.patch"
        APPLY_PATCH "system" "system/priv-app/SecSettings/SecSettings.apk" "$SRC_DIR/unica/patches/product_feature/resolution/SecSettings.apk/0001-Enable-dynamic-resolution-control.patch"
        LOG_STEP_OUT
    fi
else
    if ! $TARGET_HAS_QHD_DISPLAY; then
        # TODO: won't be necessary anyway
        true
    fi
fi

if [[ "$SOURCE_HFR_MODE" != "$TARGET_HFR_MODE" ]]; then
    LOG_STEP_IN "- Applying HFR_MODE patches"

    DECODE_APK "system" "system/framework/framework.jar"
    DECODE_APK "system" "system/framework/gamemanager.jar"
    DECODE_APK "system" "system/framework/secinputdev-service.jar"
    DECODE_APK "system" "system/priv-app/SecSettings/SecSettings.apk"
    DECODE_APK "system" "system/priv-app/SettingsProvider/SettingsProvider.apk"
    DECODE_APK "system_ext" "priv-app/SystemUI/SystemUI.apk"

    FTP="
    system/framework/framework.jar/smali_classes6/com/samsung/android/hardware/display/RefreshRateConfig.smali
    system/framework/framework.jar/smali_classes6/com/samsung/android/rune/CoreRune.smali
    system/framework/gamemanager.jar/smali/com/samsung/android/game/GameManagerService.smali
    system/framework/secinputdev-service.jar/smali/com/samsung/android/hardware/secinputdev/SemInputDeviceManagerService.smali
    system/framework/secinputdev-service.jar/smali/com/samsung/android/hardware/secinputdev/utils/SemInputFeatures.smali
    system/framework/secinputdev-service.jar/smali/com/samsung/android/hardware/secinputdev/utils/SemInputFeaturesExtra.smali
    system/priv-app/SecSettings/SecSettings.apk/smali_classes4/com/samsung/android/settings/display/SecDisplayUtils.smali
    system/priv-app/SettingsProvider/SettingsProvider.apk/smali/com/android/providers/settings/DatabaseHelper.smali
    system_ext/priv-app/SystemUI/SystemUI.apk/smali/com/android/systemui/LsRune.smali
    "
    for f in $FTP; do
        sed -i "s/\"$SOURCE_HFR_MODE\"/\"$TARGET_HFR_MODE\"/g" "$APKTOOL_DIR/$f"
    done
    LOG_STEP_OUT
fi
if [[ "$SOURCE_HFR_SUPPORTED_REFRESH_RATE" != "$TARGET_HFR_SUPPORTED_REFRESH_RATE" ]]; then
    LOG_STEP_IN "- Applying HFR_SUPPORTED_REFRESH_RATE patches"

    DECODE_APK "system" "system/framework/framework.jar"
    DECODE_APK "system" "system/priv-app/SecSettings/SecSettings.apk"

    FTP="
    system/framework/framework.jar/smali_classes6/com/samsung/android/hardware/display/RefreshRateConfig.smali
    system/priv-app/SecSettings/SecSettings.apk/smali_classes4/com/samsung/android/settings/display/SecDisplayUtils.smali
    "
    for f in $FTP; do
        if [[ "$TARGET_HFR_SUPPORTED_REFRESH_RATE" != "none" ]]; then
            sed -i "s/\"$SOURCE_HFR_SUPPORTED_REFRESH_RATE\"/\"$TARGET_HFR_SUPPORTED_REFRESH_RATE\"/g" "$APKTOOL_DIR/$f"
        else
            sed -i "s/\"$SOURCE_HFR_SUPPORTED_REFRESH_RATE\"/\"\"/g" "$APKTOOL_DIR/$f"
        fi
    done
    LOG_STEP_OUT
fi
if [[ "$SOURCE_HFR_DEFAULT_REFRESH_RATE" != "$TARGET_HFR_DEFAULT_REFRESH_RATE" ]]; then
    LOG_STEP_IN "- Applying HFR_DEFAULT_REFRESH_RATE patches"

    DECODE_APK "system" "system/framework/framework.jar"
    DECODE_APK "system" "system/priv-app/SecSettings/SecSettings.apk"
    DECODE_APK "system" "system/priv-app/SettingsProvider/SettingsProvider.apk"

    FTP="
    system/framework/framework.jar/smali_classes6/com/samsung/android/hardware/display/RefreshRateConfig.smali
    system/priv-app/SecSettings/SecSettings.apk/smali_classes4/com/samsung/android/settings/display/SecDisplayUtils.smali
    system/priv-app/SettingsProvider/SettingsProvider.apk/smali/com/android/providers/settings/DatabaseHelper.smali
    "
    for f in $FTP; do
        sed -i "s/\"$SOURCE_HFR_DEFAULT_REFRESH_RATE\"/\"$TARGET_HFR_DEFAULT_REFRESH_RATE\"/g" "$APKTOOL_DIR/$f"
    done
    LOG_STEP_OUT
fi
if [[ "$SOURCE_HFR_SEAMLESS_BRT" != "$TARGET_HFR_SEAMLESS_BRT" ]] || \
    [[ "$SOURCE_HFR_SEAMLESS_LUX" != "$TARGET_HFR_SEAMLESS_LUX" ]]; then
    LOG_STEP_IN "- Applying HFR_SEAMLESS_BRT/HFR_SEAMLESS_LUX patches"

    if [[ "$TARGET_HFR_SEAMLESS_BRT" == "none" ]] && [[ "$TARGET_HFR_SEAMLESS_LUX" == "none" ]]; then
        true
    else
        DECODE_APK "system" "system/framework/framework.jar"

        FTP="
        system/framework/framework.jar/smali_classes6/com/samsung/android/hardware/display/RefreshRateConfig.smali
        "
        for f in $FTP; do
            sed -i "s/\"$SOURCE_HFR_SEAMLESS_BRT\"/\"$TARGET_HFR_SEAMLESS_BRT\"/g" "$APKTOOL_DIR/$f"
            sed -i "s/\"$SOURCE_HFR_SEAMLESS_LUX\"/\"$TARGET_HFR_SEAMLESS_LUX\"/g" "$APKTOOL_DIR/$f"
        done
    fi
    LOG_STEP_OUT
fi

if [[ "$SOURCE_MULTI_MIC_MANAGER_VERSION" != "$TARGET_MULTI_MIC_MANAGER_VERSION" ]]; then
    LOG_STEP_IN "- Applying SemMultiMicManager patches"

    DECODE_APK "system" "system/framework/framework.jar"

    FTP="
    system/framework/framework.jar/smali_classes6/com/samsung/android/camera/mic/SemMultiMicManager.smali
    "
    for f in $FTP; do
        sed -i "s/$SOURCE_MULTI_MIC_MANAGER_VERSION/$TARGET_MULTI_MIC_MANAGER_VERSION/g" "$APKTOOL_DIR/$f"
    done
    LOG_STEP_OUT
fi

if [[ "$SOURCE_SSRM_CONFIG_NAME" != "$TARGET_SSRM_CONFIG_NAME" ]]; then
    LOG_STEP_IN "- Applying SSRM patches"

    DECODE_APK "system" "system/framework/ssrm.jar"

    FTP="
    system/framework/ssrm.jar/smali/com/android/server/ssrm/Feature.smali
    "
    for f in $FTP; do
        sed -i "s/$SOURCE_SSRM_CONFIG_NAME/$TARGET_SSRM_CONFIG_NAME/g" "$APKTOOL_DIR/$f"
    done

    SET_FLOATING_FEATURE_CONFIG "SEC_FLOATING_FEATURE_SYSTEM_CONFIG_SIOP_POLICY_FILENAME" "$TARGET_SSRM_CONFIG_NAME"
    LOG_STEP_OUT
fi
if [[ "$SOURCE_DVFS_CONFIG_NAME" != "$TARGET_DVFS_CONFIG_NAME" ]]; then
    LOG_STEP_IN "- Applying DVFS patches"

    DECODE_APK "system" "system/framework/ssrm.jar"

    FTP="
    system/framework/ssrm.jar/smali/com/android/server/ssrm/Feature.smali
    "
    for f in $FTP; do
        sed -i "s/$SOURCE_DVFS_CONFIG_NAME/$TARGET_DVFS_CONFIG_NAME/g" "$APKTOOL_DIR/$f"
    done
    LOG_STEP_OUT
fi

if $SOURCE_IS_ESIM_SUPPORTED; then
    if ! $TARGET_IS_ESIM_SUPPORTED; then
        SET_FLOATING_FEATURE_CONFIG "SEC_FLOATING_FEATURE_COMMON_CONFIG_EMBEDDED_SIM_SLOTSWITCH" --delete
        SET_FLOATING_FEATURE_CONFIG "SEC_FLOATING_FEATURE_COMMON_SUPPORT_EMBEDDED_SIM" --delete
    fi
fi

APPLY_PATCH "system" "system/priv-app/SamsungDeviceHealthManagerService/SamsungDeviceHealthManagerService.apk" \
        "$SRC_DIR/unica/patches/product_feature/ssrm/SamsungDeviceHealthManagerService.apk/0001-Nuke-SSRM-Warning-dialog.patch"

if [ ! -f "$FW_DIR/${MODEL}_${REGION}/vendor/etc/permissions/android.hardware.strongbox_keystore.xml" ]; then
    LOG_STEP_IN "- Applying strongbox patches"
    APPLY_PATCH "system" "system/framework/framework.jar" "$SRC_DIR/unica/patches/product_feature/strongbox/framework.jar/0001-Disable-StrongBox-in-DevRootKeyATCmd.patch"
    LOG_STEP_OUT
fi
