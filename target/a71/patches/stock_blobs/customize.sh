LOG_STEP_IN "- Adding a73xqxx keymaster libs"
DELETE_FROM_WORK_DIR "system" "system/lib/android.hardware.security.keymint-V2-ndk.so"
DELETE_FROM_WORK_DIR "system" "system/lib/android.hardware.security.secureclock-V1-ndk.so"
DELETE_FROM_WORK_DIR "system" "system/lib/libdk_native_keymint.so"
DELETE_FROM_WORK_DIR "system" "system/lib/vendor.samsung.hardware.keymint-V2-ndk.so"
DELETE_FROM_WORK_DIR "system" "system/lib64/android.hardware.security.keymint-V2-ndk.so"
DELETE_FROM_WORK_DIR "system" "system/lib64/libdk_native_keymint.so"
DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.keymint-V2-ndk.so"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib/android.hardware.keymaster@3.0.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib/android.hardware.keymaster@4.0.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib/android.hardware.keymaster@4.1.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib/lib_nativeJni.dk.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib/libdk_native_keymaster.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib/libkeymaster4_1support.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib/libkeymaster4support.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/lib_nativeJni.dk.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libdk_native_keymaster.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a73xqxx MIDAS"
DELETE_FROM_WORK_DIR "vendor" "etc/midas"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "etc/midas"
LOG_STEP_OUT

LOG_STEP_IN "- Fixing MIDAS model detection"
sed -i "s/a73xq/a71/g" "$WORK_DIR/vendor/etc/midas/midas_config.json"
sed -i "s/ro.product.device/ro.product.vendor.device/g" "$WORK_DIR/vendor/etc/midas/midas_config.json"
LOG_STEP_OUT

LOG_STEP_IN "- Fixing MIDAS, AI and camera"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/etc/public.libraries-camera.samsung.txt"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libSlowShutter_jni.media.samsung.so"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/lib_nativeJni.dk.samsung.so"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libmidas_DNNInterface.camera.samsung.so"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libmidas_core.camera.samsung.so"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libsamsung_videoengine_9_0.so"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libtensorflowLite.camera.samsung.so"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libtensorflowlite_inference_api.camera.samsung.so"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/priv-app/PhotoRemasterService/PhotoRemasterService.apk"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a73xqxx WFD blobs"
DELETE_FROM_WORK_DIR "system" "system/lib64/libhdcp_client_aidl.so"
DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.security.hdcp.wifidisplay-V2-ndk.so"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/bin/insthk" 0 2000 755 "u:object_r:insthk_exec:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/bin/remotedisplay" 0 2000 755 "u:object_r:remotedisplay_exec:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libhdcp2.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libremotedisplay.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libremotedisplay_wfd.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libremotedisplayservice.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libsecuibc.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libstagefright_hdcp.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a73xqxx wpa_supplicant"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "bin/hw/wpa_supplicant"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a52qnsxx SoundBooster libs"
DELETE_FROM_WORK_DIR "system" "system/lib/lib_SoundBooster_ver1100.so"
DELETE_FROM_WORK_DIR "system" "system/lib64/lib_SoundBooster_ver1100.so"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/lib/lib_SoundBooster_ver1050.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/lib/libsamsungSoundbooster_plus_legacy.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/lib64/lib_SoundBooster_ver1050.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/lib64/libsamsungSoundbooster_plus_legacy.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Fixing RIL"
sed -i "s/1.4::IRadio/1.5::IRadio/g" "$WORK_DIR/vendor/etc/vintf/manifest.xml"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a73xqxx biometric blobs"
DELETE_FROM_WORK_DIR "vendor" "bin/hw/vendor.samsung.hardware.biometrics.face@2.0-service"
DELETE_FROM_WORK_DIR "vendor" "etc/init/vendor.samsung.hardware.biometrics.face@2.0-service.rc"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "bin/hw/vendor.samsung.hardware.biometrics.face@3.0-service"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "etc/init/vendor.samsung.hardware.biometrics.face@3.0-service.rc"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "lib/vendor.samsung.hardware.biometrics.face@2.0.so"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "lib/vendor.samsung.hardware.biometrics.face@3.0.so"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "lib64/vendor.samsung.hardware.biometrics.face@2.0.so"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "lib64/vendor.samsung.hardware.biometrics.face@3.0.so"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a73xqxx light blobs"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "bin/hw/vendor.samsung.hardware.light-service"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "lib64/vendor.samsung.hardware.light-V1-ndk_platform.so"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a73xq saiv blobs"
DELETE_FROM_WORK_DIR "system" "system/saiv"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/saiv" 0 0 755 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Adding stock rscmgr.rc"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/init/rscmgr.rc" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a52qnsxx CameraLightSensor app"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/etc/permissions/privapp-permissions-com.samsung.adaptivebrightnessgo.cameralightsensor.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/priv-app/CameraLightSensor/CameraLightSensor.apk" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a52qnsxx FMRadio blobs"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/etc/permissions/privapp-permissions-com.sec.android.app.fm.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/etc/sysconfig/preinstalled-packages-com.sec.android.app.fm.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/priv-app/HybridRadio/HybridRadio.apk" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/lib/libfmradio_jni.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/lib64/libfmradio_jni.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system_ext" "lib/fm_helium.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system_ext" "lib/libbeluga.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system_ext" "lib/libfm-hci.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system_ext" "lib/vendor.qti.hardware.fm@1.0.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system_ext" "lib64/fm_helium.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system_ext" "lib64/libbeluga.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system_ext" "lib64/libfm-hci.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system_ext" "lib64/vendor.qti.hardware.fm@1.0.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Add A73 vintf manifest"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/etc/vintf/manifest.xml" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Fixing vintf manifest"
sed -i 's/manifest version="8\.0"/manifest version="9.0"/' "$WORK_DIR/system/system/etc/vintf/manifest.xml"
sed -i 's/manifest version="8\.0"/manifest version="9.0"/' "$WORK_DIR/system/system/system_ext/etc/vintf/manifest.xml"
LOG_STEP_OUT

LOG_STEP_IN "- Adding stock system features"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.samsung.feature.audio_fast_listenback.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.samsung.feature.audio_listenback.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.cover.clearcameraviewcover.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.cover.flip.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.nsflp_level_601.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.pocketsensitivitymode_level1.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.sensorhub_level29.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.wirelesscharger_authentication.xml"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.cover.minisviewwalletcover.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.nsflp_level_600.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.pocketmode_level6.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.sensorhub_level34.xml" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a52qnsxx TUI app"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/etc/sysconfig/preinstalled-packages-com.qualcomm.qti.services.secureui.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system_ext" "app/com.qualcomm.qti.services.secureui/com.qualcomm.qti.services.secureui.apk" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system_ext" "lib/libqcc_file_agent_sys.so" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system_ext" "lib64/libqcc_file_agent_sys.so" 0 0 644 "u:object_r:system_file:s0"

LOG_STEP_IN "- Fixing selinux entry"
sed -i '/init\.svc\.vendor\.wvkprov_server_hal/d' "$WORK_DIR/vendor/etc/selinux/vendor_property_contexts"
LOG_STEP_OUT

LOG_STEP_IN "- Adding tlc dependencies"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "vendor" "lib/vendor.qti.hardware.trustedui@1.0.so" 0 0 644 "u:object_r:vendor_file:s0"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "vendor" "lib/vendor.qti.hardware.trustedui@1.1.so" 0 0 644 "u:object_r:vendor_file:s0"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "vendor" "lib/vendor.qti.hardware.trustedui@1.2.so" 0 0 644 "u:object_r:vendor_file:s0"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "vendor" "lib/vendor.qti.hardware.tui_comm@1.0.so" 0 0 644 "u:object_r:vendor_file:s0"

ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "vendor" "lib64/vendor.qti.hardware.trustedui@1.0.so" 0 0 644 "u:object_r:vendor_file:s0"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "vendor" "lib64/vendor.qti.hardware.trustedui@1.1.so" 0 0 644 "u:object_r:vendor_file:s0"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "vendor" "lib64/vendor.qti.hardware.trustedui@1.2.so" 0 0 644 "u:object_r:vendor_file:s0"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "vendor" "lib64/vendor.qti.hardware.tui_comm@1.0.so" 0 0 644 "u:object_r:vendor_file:s0"

mv "$WORK_DIR/vendor/lib/vendor.qti.hardware.trustedui@1.0.so" "$WORK_DIR/system/system/lib/"
mv "$WORK_DIR/vendor/lib/vendor.qti.hardware.trustedui@1.1.so" "$WORK_DIR/system/system/lib/"
mv "$WORK_DIR/vendor/lib/vendor.qti.hardware.trustedui@1.2.so" "$WORK_DIR/system/system/lib/"

mv "$WORK_DIR/vendor/lib64/vendor.qti.hardware.trustedui@1.0.so" "$WORK_DIR/system/system/lib64/"
mv "$WORK_DIR/vendor/lib64/vendor.qti.hardware.trustedui@1.1.so" "$WORK_DIR/system/system/lib64/"
mv "$WORK_DIR/vendor/lib64/vendor.qti.hardware.trustedui@1.2.so" "$WORK_DIR/system/system/lib64/"

echo "system/lib/vendor.qti.hardware.trustedui@1.0.so 0 0 644 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"
echo "system/lib/vendor.qti.hardware.trustedui@1.1.so 0 0 644 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"
echo "system/lib/vendor.qti.hardware.trustedui@1.2.so 0 0 644 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"

echo "system/lib64/vendor.qti.hardware.trustedui@1.0.so 0 0 644 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"
echo "system/lib64/vendor.qti.hardware.trustedui@1.1.so 0 0 644 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"
echo "system/lib64/vendor.qti.hardware.trustedui@1.2.so 0 0 644 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"

echo "/system/lib/vendor\.qti\.hardware\.trustedui@1\.0\.so u:object_r:system_lib_file:s0" >> "$WORK_DIR/configs/file_context-system"
echo "/system/lib/vendor\.qti\.hardware\.trustedui@1\.1\.so u:object_r:system_lib_file:s0" >> "$WORK_DIR/configs/file_context-system"
echo "/system/lib/vendor\.qti\.hardware\.trustedui@1\.2\.so u:object_r:system_lib_file:s0" >> "$WORK_DIR/configs/file_context-system"

echo "/system/lib64/vendor\.qti\.hardware\.trustedui@1\.0\.so u:object_r:system_lib_file:s0" >> "$WORK_DIR/configs/file_context-system"
echo "/system/lib64/vendor\.qti\.hardware\.trustedui@1\.1\.so u:object_r:system_lib_file:s0" >> "$WORK_DIR/configs/file_context-system"
echo "/system/lib64/vendor\.qti\.hardware\.trustedui@1\.2\.so u:object_r:system_lib_file:s0" >> "$WORK_DIR/configs/file_context-system"
LOG_STEP_OUT
