LOG_STEP_IN "- Add stock rscmgr.rc"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/init/rscmgr.rc" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Add stock CameraLightSensor app"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/etc/permissions/privapp-permissions-com.samsung.adaptivebrightnessgo.cameralightsensor.xml" \
    0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/priv-app/CameraLightSensor/CameraLightSensor.apk" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Add a73xqxx vintf manifest"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/etc/vintf/manifest.xml" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Fixing vintf manifest"
sed -i 's/manifest version="8\.0"/manifest version="9.0"/' "$WORK_DIR/system/system/etc/vintf/manifest.xml"
sed -i 's/manifest version="8\.0"/manifest version="9.0"/' "$WORK_DIR/system/system/system_ext/etc/vintf/manifest.xml"
LOG_STEP_OUT

DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.cover.clearcameraviewcover.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.cover.flip.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.pocketsensitivitymode_level1.xml"
LOG_STEP_IN "- Add stock system features"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.cover.clearsideviewcover.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.pocketmode_level33.xml" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Add stock ev_lux_map_config.xml"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/ev_lux_map_config.xml" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Add stock GameDriver"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/priv-app/GameDriver-SM8250/GameDriver-SM8250.apk" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Add stock TUI app"
ADD_TO_WORK_DIR "a52qnsxx" "system" "system/etc/sysconfig/preinstalled-packages-com.qualcomm.qti.services.secureui.xml" \
    0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "a52qnsxx" "system_ext" "app/com.qualcomm.qti.services.secureui/com.qualcomm.qti.services.secureui.apk" \
    0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Add a73xqxx libhwui"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib/libhwui.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libhwui.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

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

LOG_STEP_IN "- Fixing Google Assistant"
DELETE_FROM_WORK_DIR "product" "priv-app/HotwordEnrollmentOKGoogleEx4HEXAGON"
DELETE_FROM_WORK_DIR "product" "priv-app/HotwordEnrollmentXGoogleEx4HEXAGON"
ADD_TO_WORK_DIR "a73xqxx" "product" "priv-app/HotwordEnrollmentOKGoogleEx3HEXAGON"
ADD_TO_WORK_DIR "a73xqxx" "product" "priv-app/HotwordEnrollmentXGoogleEx3HEXAGON"
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

LOG_STEP_IN "- Adding pa1qxxx nfc blobs"
DELETE_FROM_WORK_DIR "system" "system/lib64/libnfc_nxpsn_jni.so"
ADD_TO_WORK_DIR "pa1qxxx" "system" "system/lib64/libnfc_sec_jni.so"
ADD_TO_WORK_DIR "pa1qxxx" "system" "system/lib64/libnfc-nci_flags.so"
ADD_TO_WORK_DIR "pa1qxxx" "system" "system/lib64/libnfc-sec.so"
ADD_TO_WORK_DIR "pa1qxxx" "system" "system/lib64/libstatslog_nfc.so"
LOG_STEP_OUT
