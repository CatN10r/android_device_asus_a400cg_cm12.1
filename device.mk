#
# Copyright 2014 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
ifeq ($(USE_KERNEL_INLINE), true)
 ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/asus/a400cg-kernel/kernel
 else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
 endif

PRODUCT_COPY_FILES := \
	$(LOCAL_KERNEL):kernel
endif # USE_KERNEL_INLINE

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# cm overlay
DEVICE_PACKAGE_OVERLAYS += device/asus/a400cg/overlay

PRODUCT_CHARACTERISTICS := default

# Wifi
PRODUCT_PACKAGES += \
  libwpa_client \
  hostapd \
  dhcpcd.conf \
  wpa_supplicant \
  cm_audiotest

# Key layout files
PRODUCT_COPY_FILES += \
    device/asus/a400cg/keylayout/ASUS_TransKeyboard.kl:system/usr/keylayout/ASUS_TransKeyboard.kl \
    device/asus/a400cg/keylayout/himax-touchscreen.kcm:system/usr/keychars/himax-touchscreen.kcm \
    device/asus/a400cg/keylayout/himax-touchscreen.kl:system/usr/keylayout/himax-touchscreen.kl \
    device/asus/a400cg/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/asus/a400cg/keylayout/cloverview_audio_Intel_MID_Audio_Jack.kl:system/usr/keylayout/cloverview_audio_Intel_MID_Audio_Jack.kl \
    device/asus/a400cg/keylayout/headset_dev.kl:system/usr/keylayout/headset_dev.kl \
    device/asus/a400cg/keylayout/Vendor_0b05_Product_17fc.kl:system/usr/keylayout/Vendor_0b05_Product_17fc.kl \
    device/asus/a400cg/keylayout/Vendor_0b05_Product_1803.kl:system/usr/keylayout/Vendor_0b05_Product_1803.kl \
    device/asus/a400cg/keylayout/Vendor_0b05_Product_4500.kl:system/usr/keylayout/Vendor_0b05_Product_4500.kl

# Input Device Configuration (IDC) files for touchscreen (eliminates pointer cursor)
PRODUCT_COPY_FILES += \
    device/asus/a400cg/rootdir/usr/idc/himax-touchscreen.idc:system/usr/idc/himax-touchscreen.idc \
    device/asus/a400cg/rootdir/usr/idc/synaptics_rmi4_i2c.idc:system/usr/idc/synaptics_rmi4_i2c.idc \
    device/asus/a400cg/rootdir/usr/idc/rmi4_ts.idc:system/usr/idc/rmi4_ts.idc \
    device/asus/a400cg/rootdir/usr/idc/ASUS_TransKeyboard.idc:system/usr/idc/ASUS_TransKeyboard.idc \
    device/asus/a400cg/rootdir/usr/idc/Vendor_0b05_Product_17fc.idc:system/usr/idc/Vendor_0b05_Product_17fc.idc \
    device/asus/a400cg/rootdir/usr/idc/Vendor_0b05_Product_1803.idc:system/usr/idc/Vendor_0b05_Product_1803.idc

#bluetooth
PRODUCT_COPY_FILES += \
        device/asus/a400cg/configs/bt_redhookbay_ttyMFD0.conf:system/etc/bluetooth/bt_redhookbay_ttyMFD0.conf \
        device/asus/a400cg/configs/bt_redhookbay_ttyMFD0.conf:system/etc/bluetooth/bt_vendor.conf \
        device/asus/a400cg/configs/bt_redhookbay_ttyMFD3.conf:system/etc/bluetooth/bt_redhookbay_ttyMFD3.conf

# camera & modem fixups
PRODUCT_COPY_FILES += \
        vendor/asus/a400cg/proprietary/system/vendor/etc/style.cng:system/vendor/etc/style.cng \
        vendor/asus/a400cg/proprietary/system/vendor/etc/style.cng:system/etc/style.cng \
        vendor/asus/a400cg/proprietary/system/etc/mamgr/xmm1.xml:system/etc/mamgr/xmm1.xml \
        vendor/asus/a400cg/proprietary/system/etc/mamgr/xmm1.xml:system/vendor/etc/mamgr/xmm1.xml

# media (stock V7.3.3 OMX codecs & profiles)
PRODUCT_COPY_FILES += \
    vendor/asus/a400cg/proprietary/system/etc/media_profiles.xml:system/etc/media_profiles.xml \
    device/asus/a400cg/configs/wrs_omxil_components.list:system/etc/wrs_omxil_components.list \
    vendor/asus/a400cg/proprietary/system/etc/media_codecs.xml:system/etc/media_codecs.xml

PRODUCT_COPY_FILES += \
     frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
     frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
     frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml

# video decoder encoder (stock V7.3.3 Intel OMX libraries)
PRODUCT_PACKAGES += \
    libwrs_omxil_common \
    libwrs_omxil_core_pvwrapped

PRODUCT_COPY_FILES += \
    vendor/asus/a400cg/proprietary/system/lib/libOMXVideoDecoderAVC.so:system/lib/libOMXVideoDecoderAVC.so \
    vendor/asus/a400cg/proprietary/system/lib/libOMXVideoDecoderAVCSecure.so:system/lib/libOMXVideoDecoderAVCSecure.so \
    vendor/asus/a400cg/proprietary/system/lib/libOMXVideoDecoderH263.so:system/lib/libOMXVideoDecoderH263.so \
    vendor/asus/a400cg/proprietary/system/lib/libOMXVideoDecoderMPEG4.so:system/lib/libOMXVideoDecoderMPEG4.so \
    vendor/asus/a400cg/proprietary/system/lib/libOMXVideoDecoderWMV.so:system/lib/libOMXVideoDecoderWMV.so \
    vendor/asus/a400cg/proprietary/system/lib/libOMXVideoEncoderAVC.so:system/lib/libOMXVideoEncoderAVC.so \
    vendor/asus/a400cg/proprietary/system/lib/libOMXVideoEncoderH263.so:system/lib/libOMXVideoEncoderH263.so \
    vendor/asus/a400cg/proprietary/system/lib/libOMXVideoEncoderMPEG4.so:system/lib/libOMXVideoEncoderMPEG4.so

# specific audio (stock V7.3.3 audio_policy, audio_effects & parameter-framework)
PRODUCT_COPY_FILES += \
    vendor/asus/a400cg/proprietary/system/etc/audio_policy.conf:system/etc/audio_policy.conf \
    vendor/asus/a400cg/proprietary/system/etc/audio_effects.conf:system/etc/audio_effects.conf \
    device/asus/a400cg/audio/asound.conf:system/etc/asound.conf \
    device/asus/a400cg/audio/asound-vv.conf:system/etc/asound-vv.conf \
    device/asus/a400cg/audio/audio_volume_curve.conf:system/etc/audio_volume_curve.conf \
    device/asus/a400cg/audio/icesoundpresets.def:system/etc/icesoundpresets.def \
    device/asus/a400cg/audio/route_criteria.conf:system/etc/route_criteria.conf \
    device/asus/a400cg/audio/route_criteria.conf:system/vendor/etc/route_criteria.conf \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/ParameterFrameworkConfiguration.xml:system/etc/parameter-framework/ParameterFrameworkConfiguration.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/ParameterFrameworkConfigurationRoute.xml:system/etc/parameter-framework/ParameterFrameworkConfigurationRoute.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/ParameterFrameworkConfigurationVibrator.xml:system/etc/parameter-framework/ParameterFrameworkConfigurationVibrator.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Settings/Audio/AudioConfigurableDomains.xml:system/etc/parameter-framework/Settings/Audio/AudioConfigurableDomains.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Settings/Route/RouteConfigurableDomains.xml:system/etc/parameter-framework/Settings/Route/RouteConfigurableDomains.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Settings/Vibrator/VibratorConfigurableDomains.xml:system/etc/parameter-framework/Settings/Vibrator/VibratorConfigurableDomains.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Audio/AudioClass.xml:system/etc/parameter-framework/Structure/Audio/AudioClass.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Audio/ConfigurationSubsystem.xml:system/etc/parameter-framework/Structure/Audio/ConfigurationSubsystem.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Audio/IMCSubsystem.xml:system/etc/parameter-framework/Structure/Audio/IMCSubsystem.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Audio/IntelSSPSubsystem.xml:system/etc/parameter-framework/Structure/Audio/IntelSSPSubsystem.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Audio/LPEMixerSubsystem.xml:system/etc/parameter-framework/Structure/Audio/LPEMixerSubsystem.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Audio/LPESubsystem.xml:system/etc/parameter-framework/Structure/Audio/LPESubsystem.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Audio/Realtek_RT5640.xml:system/etc/parameter-framework/Structure/Audio/Realtek_RT5640.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Audio/SysfsPmdownTimeSubsystem.xml:system/etc/parameter-framework/Structure/Audio/SysfsPmdownTimeSubsystem.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Route/DebugFsSubsystem.xml:system/etc/parameter-framework/Structure/Route/DebugFsSubsystem.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Route/RouteClass.xml:system/etc/parameter-framework/Structure/Route/RouteClass.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Route/RouteSubsystem-CommonCriteria.xml:system/etc/parameter-framework/Structure/Route/RouteSubsystem-CommonCriteria.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Route/RouteSubsystem-RoutesTypes.xml:system/etc/parameter-framework/Structure/Route/RouteSubsystem-RoutesTypes.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Route/RouteSubsystem.xml:system/etc/parameter-framework/Structure/Route/RouteSubsystem.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Vibrator/MiscConfigurationSubsystem.xml:system/etc/parameter-framework/Structure/Vibrator/MiscConfigurationSubsystem.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Vibrator/SysfsVibratorClass.xml:system/etc/parameter-framework/Structure/Vibrator/SysfsVibratorClass.xml \
    vendor/asus/a400cg/proprietary/system/etc/parameter-framework/Structure/Vibrator/SysfsVibratorSubsystem.xml:system/etc/parameter-framework/Structure/Vibrator/SysfsVibratorSubsystem.xml

# init
PRODUCT_PACKAGES += \
	fstab \
	fstab.charger.redhookbay \
	fstab.ramconsole.redhookbay \
	fstab.redhookbay \
	fstab.zram \
	init.avc.rc \
	init.bt.rc \
	init.bt.vendor.rc \
	init.camera_cali.rc \
	init.common.rc \
	init.debug.rc \
	init.diag.rc \
	init.firmware.rc \
	init.gps.rc \
	init.ksm.rc \
	init.logtool.rc \
	init.modem.rc \
	init.platform.usb.rc \
	init.project.rc \
	init.readahead.rc \
	init.recovery.redhookbay.rc \
	init.redhookbay.rc \
	init.watchdog.rc \
	init.wifi.rc \
	init.wifi.vendor.rc \
	init.wireless.rc \
	init.zram.rc \
	intel_prop.cfg \
	rfkill_bt.sh \
	ueventd.project.rc \
	ueventd.redhookbay.rc \
	intel_prop \
	thermald \
	pclinkd \
	bcb_zero.bin \
	boot_logger.sh

PRODUCT_COPY_FILES += \
	device/asus/a400cg/rootdir/sbin/intel_prop:recovery/root/sbin/intel_prop \
	device/asus/a400cg/rootdir/sbin/pclinkd:recovery/root/sbin/pclinkd \
	device/asus/a400cg/rootdir/sbin/thermald:recovery/root/sbin/thermald

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Wifi (Broadcom BCM43362 stock V7.3.3 firmware, NVRAM & supplicant configs)
PRODUCT_COPY_FILES += \
        vendor/asus/a400cg/proprietary/system/etc/firmware/fw_bcmdhd.bin:system/etc/firmware/fw_bcmdhd.bin \
        vendor/asus/a400cg/proprietary/system/etc/firmware/fw_bcmdhd_apsta.bin:system/etc/firmware/fw_bcmdhd_apsta.bin \
        vendor/asus/a400cg/proprietary/system/etc/wifi/bcmdhd.cal:system/etc/wifi/bcmdhd.cal \
        vendor/asus/a400cg/proprietary/system/etc/wifi/default_network.conf:system/etc/wifi/default_network.conf \
        vendor/asus/a400cg/proprietary/system/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
        vendor/asus/a400cg/proprietary/system/etc/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
        vendor/asus/a400cg/proprietary/system/etc/wifi/p2p_supplicant.conf:system/etc/wifi/p2p_supplicant.conf \
        device/asus/a400cg/wifi/hostapd.conf:system/etc/wifi/hostapd.conf \
        device/asus/a400cg/wifi/TQS.ini:system/etc/wifi/TQS.ini
	
# GPS
PRODUCT_COPY_FILES += \
        device/asus/a400cg/gps/gpsconfig_debug.xml:system/etc/gpsconfig_debug.xml \
        device/asus/a400cg/gps/gpsconfig_user.xml:system/etc/gpsconfig_user.xml \
        device/asus/a400cg/gps/libgps.conf:system/etc/libgps.conf \
        device/asus/a400cg/gps/gps.conf:system/etc/gps.conf \
        device/asus/a400cg/gps/gpsd_mgr.sh:system/etc/gpsd_mgr.sh

PRODUCT_COPY_FILES += \
        device/asus/a400cg/gps/get-gps-lto:system/bin/get-gps-lto \
        device/asus/a400cg/gps/gpsd:system/bin/gpsd \
        device/asus/a400cg/gps/gpslogd:system/bin/gpslogd

#atproxy_usbreset
PRODUCT_COPY_FILES += \
        device/asus/a400cg/atproxy_usbreset:system/bin/atproxy_usbreset

#configure trace modem
PRODUCT_COPY_FILES += \
               device/asus/a400cg/activate_trace_modem:system/bin/activate_trace_modem \
               device/asus/a400cg/configure_trace_modem:system/bin/configure_trace_modem

#logtoold##############################################################################################
PRODUCT_COPY_FILES += \
    device/asus/a400cg/logtoold/asus_mts:system/bin/asus_mts \
    device/asus/a400cg/logtoold/klogdog:system/bin/klogdog \
    device/asus/a400cg/logtoold/logdog:system/bin/logdog \
    device/asus/a400cg/logtoold/logt_bootup:system/bin/logt_bootup \
    device/asus/a400cg/logtoold/logt_bootup_cos:system/bin/logt_bootup_cos \
    device/asus/a400cg/logtoold/logt_bootup_mos:system/bin/logt_bootup_mos \
    device/asus/a400cg/logtoold/logt_cosklogdog:system/bin/logt_cosklogdog \
    device/asus/a400cg/logtoold/logt_coslogdog:system/bin/logt_coslogdog \
    device/asus/a400cg/logtoold/logt_onechance:system/bin/logt_onechance \
    device/asus/a400cg/logtoold/start_modem_setting:system/bin/start_modem_setting \
    device/asus/a400cg/logtoold/stop_modem_setting:system/bin/stop_modem_setting \
    device/asus/a400cg/logtoold/proxy:system/bin/proxy \
    device/asus/a400cg/logtoold/uts_bootup:system/bin/uts_bootup

PRODUCT_COPY_FILES += \
    device/asus/a400cg/logtoold/EmptyActivity.obj:system/bin/EmptyActivity.obj \
    device/asus/a400cg/logtoold/monkey_test:system/bin/monkey_test \
    device/asus/a400cg/logtoold/profiling:system/bin/profiling

PRODUCT_COPY_FILES += \
    device/asus/a400cg/logtoold/scripts/monkey/EmptyActivity.obj:system/scripts/monkey/EmptyActivity.obj \
    device/asus/a400cg/logtoold/scripts/monkey/monkey_test_a:system/scripts/monkey/monkey_test_a \
    device/asus/a400cg/logtoold/scripts/monkey/monkey_test_p:system/scripts/monkey/monkey_test_p \
    device/asus/a400cg/logtoold/scripts/monkey/package_list.txt:system/scripts/monkey/package_list.txt \
    device/asus/a400cg/logtoold/scripts/monkey/profiling:system/scripts/monkey/profiling \
    device/asus/a400cg/logtoold/scripts/monkey/script2log:system/scripts/monkey/script2log \
    device/asus/a400cg/logtoold/scripts/monkey/TestIME.obj:system/scripts/monkey/TestIME.obj \
    device/asus/a400cg/logtoold/scripts/monkey/timer:system/scripts/monkey/timer

PRODUCT_COPY_FILES += \
    device/asus/a400cg/logtoold/logdog-events.conf:system/etc/logdog-events.conf \
    device/asus/a400cg/logtoold/logdog-main.conf:system/etc/logdog-main.conf \
    device/asus/a400cg/logtoold/logdog-radio.conf:system/etc/logdog-radio.conf \
    device/asus/a400cg/logtoold/logdog-system.conf:system/etc/logdog-system.conf \
    device/asus/a400cg/logtoold/pnpDump.sh:system/etc/pnpDump.sh \
    device/asus/a400cg/logtoold/pwr-balance.sh:system/etc/pwr-balance.sh \
    device/asus/a400cg/logtoold/pwr-normal.sh:system/etc/pwr-normal.sh \
    device/asus/a400cg/logtoold/tcpDump.sh:system/etc/tcpDump.sh

##########################################################
# permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.gamepad.xml:system/etc/permissions/android.hardware.gamepad.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:system/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.software.webview.xml:system/etc/permissions/android.software.webview.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml

# Prebuilt busybox
PRODUCT_PACKAGES += \
    busybox_binary

# Tinyalsa
PRODUCT_PACKAGES += \
    tinyplay \
    tinycap \
    tinymix

# Audio
PRODUCT_PACKAGES += \
    libtinycompress \
    libtinyalsa \
    audio.a2dp.default \
    audio.primary.default \
    audio.r_submix.default \
    audio.usb.default \
    libaudioutils

# libmix
PRODUCT_PACKAGES += \
    libmixvbp \
    libmixvbp_h264 \
    libmixvbp_h264secure \
    libmixvbp_mpeg4 \
    libmixvbp_vc1

PRODUCT_PACKAGES += \
    msvdx_bin \
    topaz_bin

PRODUCT_PACKAGES += \
    libmix_imagedecoder \
    libmix_imageencoder

# psb video - provided as proprietary vendor blob (pvr_drv_video.so)
# PRODUCT_PACKAGES += \
#     pvr_drv_video

# stagefright
PRODUCT_PACKAGES += \
    libstagefrighthw

# Filesystem management tools
PRODUCT_PACKAGES += \
    e2fsck \
    tune2fs \
    resize2fs \
    make_ext4fs \
    setup_fs

# library 
PRODUCT_PACKAGES += \
    libtinyxml \
    minizip \
    openssl \
    pack_intel \
    unpack_intel

PRODUCT_PACKAGES += \
    libGLES_android \
    lights.redhookbay \
    power.redhookbay \
    libwsbm

# libdrm
PRODUCT_PACKAGES += \
    libdrm


# libI420colorconvert
PRODUCT_PACKAGES += \
	libI420colorconvert

# Intel multiple display
PRODUCT_PACKAGES += \
    libmultidisplay \
    libmultidisplayjni \
    com.intel.multidisplay \
    com.intel.multidisplay.xml

# IntelCamera Parameters extensions
PRODUCT_PACKAGES += \
    libintelcamera_jni \
    com.intel.camera.extensions \
    com.intel.camera.extensions.xml

#feature_config
PRODUCT_PACKAGES += \
	com.intel.config

# Keyhandler
PRODUCT_PACKAGES += \
    com.cyanogenmod.keyhandler

#doze
PRODUCT_PACKAGES += \
    XDoze

PRODUCT_PACKAGES += \
    Stk

# AOSP and contains Intel optimizations to the compiler.
PRODUCT_PACKAGES += libart-extension

# set USB OTG enabled to add support for USB storage type
PRODUCT_PROPERTY_OVERRIDES += persist.sys.isUsbOtgEnabled=true

# Set the prop to enable arm native bridge
ADDITIONAL_DEFAULT_PROPERTIES += ro.dalvik.vm.native.bridge=libhoudini.so

# usb
PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory

# Set default composite USB interface (MTP + ADB)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp,adb

#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true

PRODUCT_PROPERTY_OVERRIDES += \
	rild.libpath=/system/lib/librapid-ril-core.so \
	ro.streaming.video.drs=true \
	keyguard.no_require_sim=true \
	ro.com.android.dataroaming=true \
	ro.telephony.default_network=9 \
	ro.telephony.ril_class=AsusRIL

PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=0 \
    persist.tel.lteOnGsmDevice=false \
    persist.radio.multisim.config=dsds \
    persist.tel.hot_swap.support=true \
    persist.sys.media.use-awesome=true

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.ril-daemon.disable=0 \
	persist.radio.ril_modem_state=1

#dalvik
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	dalvik.vm.dex2oat-Xms=64m \
	dalvik.vm.dex2oat-Xmx=512m \
	dalvik.vm.image-dex2oat-Xms=64m \
	dalvik.vm.image-dex2oat-Xmx=64m

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.zygote=zygote32

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=240 \
    ro.opengles.version=131072

PRODUCT_TAGS += dalvik.gc.type-precise

ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.build.asus.sku=WW \
    ro.debuggable=1 \
    ro.allow.mock.location=1 \
    persist.sys.usb.config=mtp,adb \
    ro.secure=0 \
    ro.adb.secure=0 \
    panel.physicalWidthmm=52 \
    panel.physicalHeightmm=86

ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.config.low_ram=false \
    ro.ril.status.polling.enable=0 \
    ro.product.cpu.abi2=armeabi-v7a \
    ro.config.personality=compat_layout

ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.sf.lcd_density=240 \
    ro.opengles.version=131072 \
    gsm.net.interface=rmnet0 \
    persist.system.at-proxy.mode=0 \
    ro.dalvik.vm.native.bridge=libhoudini.so \
    dalvik.vm.dex2oat-Xms=64m \
    dalvik.vm.dex2oat-Xmx=512m \
    dalvik.vm.image-dex2oat-Xms=64m \
    dalvik.vm.image-dex2oat-Xmx=64m

PRODUCT_PROPERTY_OVERRIDES += \
    ro.dalvik.vm.isa.arm=x86 \
    ro.enable.native.bridge.exec=1

# bt
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	ro.gnss.sv.status=true \
	ro.bluetooth.le=2 \
	bt.version.driver=V21.23.45.2.0 \
	ro.bt.uart=ttyMFD0

#gps
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	gps.version.driver=6.19.6.216527 \
	persist.gps.ignore_rom_alm=0 \
	ril.agpschannel=/dev/gsmtty7 \
	persist.gps.psm=enabled \
	persist.gps.testmode=disabled \
	gsm.net.interface=rmnet0

PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true \
    ro.blankphone_id=1 \
    ro.contact.simtype=1 \
    ro.camera.sound.forced=0

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapminfree=4m

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hwui.texture_cache_size=20.0f \
    ro.hwui.texture_cache_flushrate=0.75f \
    ro.hwui.text_small_cache_width=1024 \
    ro.hwui.text_small_cache_height=256 \
    ro.hwui.text_large_cache_width=2048 \
    ro.hwui.text_large_cache_height=256

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.dalvik.vm.lib.2=libart.so \
    ro.ril.status.polling.enable=0 \
    rs.gpu.renderscript=0 \
    rs.gpu.filterscript=0 \
    rs.gpu.rsIntrinsic=0

PRODUCT_PROPERTY_OVERRIDES += \
    persist.telproviders.debug=0 \
    ro.ime.lowmemory=false

# Hardware keys (disable on-screen soft navigation bar)
PRODUCT_PROPERTY_OVERRIDES += \
    qemu.hw.mainkeys=1

# Missing proprietary HAL, Parameter-Framework, AtomISP & provisioning blobs from stock V7.3.3
PRODUCT_COPY_FILES += \
    vendor/asus/a400cg/proprietary/system/lib/libhwcwidi.so:system/lib/libhwcwidi.so \
    vendor/asus/a400cg/proprietary/system/lib/libkeymaster.so:system/lib/libkeymaster.so \
    vendor/asus/a400cg/proprietary/system/lib/libproperty.so:system/lib/libproperty.so \
    vendor/asus/a400cg/proprietary/system/lib/libinterface-provider.so:system/lib/libinterface-provider.so \
    vendor/asus/a400cg/proprietary/system/lib/libinterface-provider-lib.so:system/lib/libinterface-provider-lib.so \
    vendor/asus/a400cg/proprietary/system/lib/libsepdrm.so:system/lib/libsepdrm.so \
    vendor/asus/a400cg/proprietary/system/lib/libaudioresample.so:system/lib/libaudioresample.so \
    vendor/asus/a400cg/proprietary/system/lib/libmodem-audio-collection.so:system/lib/libmodem-audio-collection.so \
    vendor/asus/a400cg/proprietary/system/lib/audio.routemanager.so:system/lib/audio.routemanager.so \
    vendor/asus/a400cg/proprietary/system/lib/libaudience-manager.so:system/lib/libaudience-manager.so \
    vendor/asus/a400cg/proprietary/system/lib/soundfx/libicepower.so:system/lib/soundfx/libicepower.so \
    vendor/asus/a400cg/proprietary/system/lib/soundfx/liblpepreprocessing.so:system/lib/soundfx/liblpepreprocessing.so \
    vendor/asus/a400cg/proprietary/system/lib/parameter-framework-plugins/Audio/libaudience-subsystem.so:system/lib/parameter-framework-plugins/Audio/libaudience-subsystem.so \
    vendor/asus/a400cg/proprietary/system/lib/parameter-framework-plugins/Audio/libimc-subsystem.so:system/lib/parameter-framework-plugins/Audio/libimc-subsystem.so \
    vendor/asus/a400cg/proprietary/system/lib/parameter-framework-plugins/Audio/liblpe-subsystem.so:system/lib/parameter-framework-plugins/Audio/liblpe-subsystem.so \
    vendor/asus/a400cg/proprietary/system/lib/parameter-framework-plugins/Audio/libtinyalsa-subsystem.so:system/lib/parameter-framework-plugins/Audio/libtinyalsa-subsystem.so \
    vendor/asus/a400cg/proprietary/system/lib/parameter-framework-plugins/Fs/libfs-subsystem.so:system/lib/parameter-framework-plugins/Fs/libfs-subsystem.so \
    vendor/asus/a400cg/proprietary/system/lib/parameter-framework-plugins/Route/libroute-subsystem.so:system/lib/parameter-framework-plugins/Route/libroute-subsystem.so \
    vendor/asus/a400cg/proprietary/system/lib/parameter-framework-plugins/System/libproperty-subsystem.so:system/lib/parameter-framework-plugins/System/libproperty-subsystem.so \
    vendor/asus/a400cg/proprietary/system/lib/libarcsoft3DNR.so:system/lib/libarcsoft3DNR.so \
    vendor/asus/a400cg/proprietary/system/lib/libarcsoftFace.so:system/lib/libarcsoftFace.so \
    vendor/asus/a400cg/proprietary/system/lib/libarcsoftHDR.so:system/lib/libarcsoftHDR.so \
    vendor/asus/a400cg/proprietary/system/lib/libarcsoftNightHawk.so:system/lib/libarcsoftNightHawk.so \
    vendor/asus/a400cg/proprietary/system/lib/libarcsoftStabilizer.so:system/lib/libarcsoftStabilizer.so \
    vendor/asus/a400cg/proprietary/system/lib/libarcsoft_effect.so:system/lib/libarcsoft_effect.so \
    vendor/asus/a400cg/proprietary/system/lib/libtbd.so:system/lib/libtbd.so \
    vendor/asus/a400cg/proprietary/system/lib/libxditk_AT.so:system/lib/libxditk_AT.so \
    vendor/asus/a400cg/proprietary/system/lib/libxditk_DIT_CloverTrailPlus.so:system/lib/libxditk_DIT_CloverTrailPlus.so \
    vendor/asus/a400cg/proprietary/system/lib/libxditk_isp.bin:system/lib/libxditk_isp.bin \
    vendor/asus/a400cg/proprietary/system/lib/libCameraFaceDetection.so:system/lib/libCameraFaceDetection.so \
    vendor/asus/a400cg/proprietary/system/lib/libcamera_defocus.so:system/lib/libcamera_defocus.so \
    vendor/asus/a400cg/proprietary/system/lib/libcameraap.so:system/lib/libcameraap.so \
    vendor/asus/a400cg/proprietary/system/etc/firmware/shisp_css15.bin:system/etc/firmware/shisp_css15.bin \
    vendor/asus/a400cg/proprietary/system/etc/firmware/shisp_2400b0_v21.bin:system/etc/firmware/shisp_2400b0_v21.bin \
    vendor/asus/a400cg/proprietary/system/etc/firmware/isp_acc_deghosting_css15.bin:system/etc/firmware/isp_acc_deghosting_css15.bin \
    vendor/asus/a400cg/proprietary/system/etc/firmware/isp_acc_fusion_css15.bin:system/etc/firmware/isp_acc_fusion_css15.bin \
    vendor/asus/a400cg/proprietary/system/etc/firmware/isp_acc_multires_css15.bin:system/etc/firmware/isp_acc_multires_css15.bin \
    vendor/asus/a400cg/proprietary/system/etc/firmware/isp_acc_postproc_css15.bin:system/etc/firmware/isp_acc_postproc_css15.bin \
    vendor/asus/a400cg/proprietary/system/etc/firmware/isp_acc_warping_css15.bin:system/etc/firmware/isp_acc_warping_css15.bin \
    vendor/asus/a400cg/proprietary/system/etc/firmware/msvdx_fw_mfld_DE2.0.bin:system/etc/firmware/msvdx_fw_mfld_DE2.0.bin \
    vendor/asus/a400cg/proprietary/system/etc/firmware/topazsc_fw.bin:system/etc/firmware/topazsc_fw.bin \
    vendor/asus/a400cg/proprietary/system/bin/info_setting:system/bin/info_setting \
    vendor/asus/a400cg/proprietary/system/bin/wlan_prov:system/bin/wlan_prov \
    vendor/asus/a400cg/proprietary/system/bin/load_bcmdriver:system/bin/load_bcmdriver \
    vendor/asus/a400cg/proprietary/system/bin/wl:system/bin/wl \
    vendor/asus/a400cg/proprietary/system/bin/bd_prov:system/bin/bd_prov \
    vendor/asus/a400cg/proprietary/system/bin/upi_ug31xx:system/bin/upi_ug31xx \
    vendor/asus/a400cg/proprietary/system/bin/nvm_server:system/bin/nvm_server \
    vendor/asus/a400cg/proprietary/system/bin/mts:system/bin/mts \
    vendor/asus/a400cg/proprietary/system/bin/bcu_cpufreqrel:system/bin/bcu_cpufreqrel \
    vendor/asus/a400cg/proprietary/system/bin/get_sensors_calibration:system/bin/get_sensors_calibration \
    vendor/asus/a400cg/proprietary/system/bin/SensorsCalibration:system/bin/SensorsCalibration \
    vendor/asus/a400cg/proprietary/system/vendor/lib/libPVROCL.so:system/vendor/lib/libPVROCL.so \
    vendor/asus/a400cg/proprietary/system/vendor/lib/libPVRScopeServices.so:system/vendor/lib/libPVRScopeServices.so \
    vendor/asus/a400cg/proprietary/system/vendor/lib/liboclcompiler.so:system/vendor/lib/liboclcompiler.so

$(call inherit-product-if-exists, vendor/asus/a400cg/device-vendor.mk)
$(call inherit-product-if-exists, vendor/intel/houdini/houdini.mk)
