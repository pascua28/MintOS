#
# Copyright (C) 2023 Salvo Giangreco
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# UN1CA debloat list
# - Add entries inside the specific partition containing that file (<PARTITION>_DEBLOAT+="")
# - DO NOT add the partition name at the start of any entry (eg. "/system/dpolicy_system")
# - DO NOT add a slash at the start of any entry (eg. "/dpolicy_system")

# Samsung Defex policy
SYSTEM_DEBLOAT+="
dpolicy_system
"
VENDOR_DEBLOAT+="
etc/dpolicy
"

# Samsung SIM Unlock
SYSTEM_DEBLOAT+="
system/bin/ssud
system/etc/init/ssu_dm1qxxx.rc
system/etc/init/ssu.rc
system/etc/permissions/privapp-permissions-com.samsung.ssu.xml
system/etc/sysconfig/samsungsimunlock.xml
system/lib64/android.security.securekeygeneration-ndk.so
system/lib64/libssu_keystore2.so
system/priv-app/SsuService
"

if [[ "$TARGET_SINGLE_SYSTEM_IMAGE" = "essi" ]]; then
    SYSTEM_DEBLOAT+="
    system/etc/init/ssu_r11sxxx.rc
    "
fi

if [[ "$TARGET_SINGLE_SYSTEM_IMAGE" = "qssi" ]]; then
    SYSTEM_DEBLOAT+="
    system/etc/init/ssu_dm1qxxx.rc
    "
fi

# Recovery restoration script
VENDOR_DEBLOAT+="
recovery-from-boot.p
bin/install-recovery.sh
etc/init/vendor_flash_recovery.rc
"

# Apps debloat
PRODUCT_DEBLOAT+="
app/AssistantShell
app/BardShell
app/Chrome
app/DuoStub
app/Gmail2
app/Maps
app/YouTube
overlay/GmsConfigOverlaySearchSelector.apk
priv-app/Messages
priv-app/SearchSelector
"

SYSTEM_DEBLOAT+="
system/app/KidsHome_Installer
system/app/FBAppManager_NS
system/app/MoccaMobile
system/app/PlayAutoInstallConfig
system/app/SamsungPassAutofill_v1
system/app/SamsungTTSVoice_ar_AE_m00
system/app/SamsungTTSVoice_id_ID_f00
system/app/SamsungTTSVoice_de_DE_f00
system/app/SamsungTTSVoice_en_GB_f00
system/app/SamsungTTSVoice_en_US_l03
system/app/SamsungTTSVoice_es_ES_f00
system/app/SamsungTTSVoice_es_MX_f00
system/app/SamsungTTSVoice_es_US_f00
system/app/SamsungTTSVoice_fr_FR_f00
system/app/SamsungTTSVoice_hi_IN_f00
system/app/SamsungTTSVoice_it_IT_f00
system/app/SamsungTTSVoice_pl_PL_f00
system/app/SamsungTTSVoice_pt_BR_f00
system/app/SamsungTTSVoice_ru_RU_f00
system/app/SamsungTTSVoice_th_TH_f00
system/app/SamsungTTSVoice_vi_VN_f00
system/app/SilentLog
system/etc/init/samsung_pass_authenticator_service.rc
system/etc/permissions/privapp-permissions-com.microsoft.skydrive.xml
system/etc/permissions/privapp-permissions-com.samsung.android.authfw.xml
system/etc/permissions/privapp-permissions-com.samsung.android.carkey.xml
system/etc/permissions/privapp-permissions-com.samsung.android.cidmanager.xml
system/etc/permissions/privapp-permissions-com.sec.android.app.dexonpc.xml
system/etc/permissions/privapp-permissions-com.samsung.android.dkey.xml
system/etc/permissions/privapp-permissions-com.samsung.android.samsungpass.xml
system/etc/permissions/privapp-permissions-com.samsung.android.spayfw.xml
system/etc/permissions/privapp-permissions-com.sec.android.app.factorykeystring.xml
system/etc/permissions/privapp-permissions-com.sec.android.diagmonagent.xml
system/etc/permissions/privapp-permissions-com.sec.android.soagent.xml
system/etc/permissions/privapp-permissions-com.sec.bcservice.xml
system/etc/permissions/privapp-permissions-com.sec.epdgtestapp.xml
system/etc/permissions/privapp-permissions-com.sec.facatfunction.xml
system/etc/permissions/privapp-permissions-com.sem.factoryapp.xml
system/etc/permissions/privapp-permissions-com.wssyncmldm.xml
system/etc/permissions/privapp-permissions-de.axelspringer.yana.zeropage.xml
system/etc/permissions/privapp-permissions-meta.xml
system/etc/sysconfig/digitalkey.xml
system/etc/sysconfig/meta-hiddenapi-package-allowlist.xml
system/etc/sysconfig/preinstalled-packages-com.samsung.android.dkey.xml
system/etc/sysconfig/preinstalled-packages-com.samsung.android.spayfw.xml
system/etc/sysconfig/samsungauthframework.xml
system/etc/sysconfig/samsungpassapp.xml
system/hidden/SmartTutor
system/preload
system/priv-app/AuthFramework
system/priv-app/BCService
system/priv-app/CIDManager
system/priv-app/DeXonPC
system/priv-app/DiagMonAgent95
system/priv-app/DigitalKey
system/priv-app/FBInstaller_NS
system/priv-app/FBServices
system/priv-app/FotaAgent
system/priv-app/OneDrive_Samsung_v3
system/priv-app/OMCAgent5
system/priv-app/PaymentFramework
system/priv-app/SOAgent76
system/priv-app/SamsungCarKeyFw
system/priv-app/SamsungPass
system/priv-app/YourPhone_P1_5
system/priv-app/Upday
"

if [[ "$TARGET_SINGLE_SYSTEM_IMAGE" = "qssi" ]]; then
    SYSTEM_DEBLOAT+="
    system/app/DictDiotekForSec
    system/app/SamsungCalendar
    system/app/SmartReminder
    system/etc/permissions/privapp-permissions-com.samsung.android.game.gamehome.xml
    system/priv-app/GameHome
    " 
fi

# eSIM
if $SOURCE_IS_ESIM_SUPPORTED; then
    if ! $TARGET_IS_ESIM_SUPPORTED; then
        SYSTEM_DEBLOAT+="
        system/etc/permissions/privapp-permissions-com.samsung.android.app.esimkeystring.xml
        system/etc/permissions/privapp-permissions-com.samsung.euicc.xml
        system/etc/sysconfig/preinstalled-packages-com.samsung.android.app.esimkeystring.xml
        system/etc/sysconfig/preinstalled-packages-com.samsung.euicc.xml
        system/priv-app/EsimKeyString
        system/priv-app/EuiccService
        "
    fi
fi

# fabric_crypto
if [[ "$TARGET_API_LEVEL" -lt 34 ]]; then
    SYSTEM_DEBLOAT+="
    system/bin/fabric_crypto
    system/etc/init/fabric_crypto.rc
    system/etc/permissions/FabricCryptoLib.xml
    system/etc/permissions/privapp-permissions-com.samsung.android.kmxservice.xml
    system/etc/vintf/manifest/fabric_crypto_manifest.xml
    system/framework/FabricCryptoLib.jar
    system/lib64/com.samsung.security.fabric.cryptod-V1-cpp.so
    system/lib64/vendor.samsung.hardware.security.fkeymaster-V1-cpp.so
    system/lib64/vendor.samsung.hardware.security.fkeymaster-V1-ndk.so
    system/priv-app/KmxService
    "
fi
