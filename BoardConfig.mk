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

# Use the non-open-source parts, if they're present
-include vendor/asus/a400cg/BoardConfigVendor.mk

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

TARGET_ARCH := x86
TARGET_ARCH_VARIANT := x86-atom
TARGET_CPU_ABI := x86
TARGET_CPU_VARIANT := x86
TARGET_CPU_ABI2 := armeabi-v7a
TARGET_CPU_ABI_LIST := x86,armeabi-v7a,armeabi
TARGET_CPU_ABI_LIST_32_BIT := x86,armeabi-v7a,armeabi
TARGET_CPU_SMP := true
TARGET_USES_64_BIT_BINDER := true
TARGET_BOARD_PLATFORM := clovertrail
TARGET_BOOTLOADER_BOARD_NAME := EeePad
TARGET_BOARD_KERNEL_HEADERS := device/asus/a400cg/kernel-headers
TARGET_SPECIFIC_HEADER_PATH := device/asus/a400cg/include
# Hardware
BOARD_HARDWARE_CLASS := device/asus/a400cg/cmhw

# intel bootclass path
PRODUCT_BOOT_JARS += com.intel.config com.intel.multidisplay

#Kernel Build from source
TARGET_KERNEL_CROSS_COMPILE_PREFIX := x86_64-linux-android-
TARGET_KERNEL_CONFIG := cyanogenmod_a400cg_defconfig
TARGET_KERNEL_SOURCE := linux/kernel
TARGET_KERNEL_ARCH := x86
BOARD_KERNEL_IMAGE_NAME := bzImage

# Dex
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),user)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1782579200 # 1.7GByte
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216 # MByte
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216 # MByte
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

TARGET_RECOVERY_FSTAB := device/asus/a400cg/recovery.fstab

BOARD_CUSTOM_BOOTIMG_MK := device/asus/a400cg/boot-tools/boot.mk
DEVICE_BASE_BOOT_IMAGE ?= $(firstword $(wildcard device/asus/a400cg/boot-tools/boot.img vendor/asus/a400cg/boot.img))
DEVICE_BASE_RECOVERY_IMAGE ?= $(firstword $(wildcard device/asus/a400cg/boot-tools/recovery.img vendor/asus/a400cg/recovery.img))


BOARD_KERNEL_BASE := 0x01100000
BOARD_KERNEL_PAGESIZE := 2048
cmdline_extra  := loglevel=7 kmemleak=off androidboot.bootmedia=sdcard androidboot.hardware=redhookbay
cmdline_extra1 := watchdog.watchdog_thresh=0 nmi_watchdog=0
cmdline_extra2 := androidboot.spid=xxxx:xxxx:xxxx:xxxx:xxxx:xxxx androidboot.serialno=01234567890123456789
cmdline_extra3 := ip=50.0.0.2:50.0.0.1::255.255.255.0::usb0:on vmalloc=384M enforcing=0 androidboot.selinux=permissive build_version=3 bootboost=1
BOARD_KERNEL_CMDLINE := init=/init pci=noearly console=logk0 earlyprintk=nologger $(cmdline_extra) $(cmdline_extra1) $(cmdline_extra2) $(cmdline_extra3)

# SELinux
-include device/asus/a400cg/sepolicy/Sepolicy.mk

BOARD_EGL_CFG := device/asus/a400cg/egl.cfg
BOARD_EGL_WORKAROUND_BUG_10194508 := true
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true

# skip some proccess to speed up build
BOARD_SKIP_ANDROID_DOC_BUILD := true
BUILD_EMULATOR := false

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Use dlmalloc
MALLOC_IMPL := dlmalloc

# Malloc Alignment
BOARD_MALLOC_ALIGNMENT := 16

# HW_Renderer
USE_OPENGL_RENDERER := true
EGL_SWAP_BEHAVIOR_PRESERVED := true

# HWComposer
BOARD_USES_HWCOMPOSER := true

# Allow HWC to perform a final CSC on virtual displays
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

# Wifi
BOARD_WLAN_DEVICE           := bcmdhd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER        := NL80211
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_AP      := "/system/etc/firmware/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_STA     := "/system/etc/firmware/fw_bcmdhd.bin"

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/asus/a400cg/bluetooth

# Audio
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_TINY_ALSA_AUDIO := true

# OMX
ENABLE_IMG_GRAPHICS := true
INTEL_VA := true
BUILD_WITH_FULL_STAGEFRIGHT := true
BOARD_USE_LIBVA := true
BOARD_USE_LIBMIX := true
BOARD_USES_MRST_OMX := true
BOARD_USES_WRS_OMXIL_CORE := true
USE_HW_VP8 := true
USE_INTEL_SECURE_AVC := true
SW_MPEG4_ENCODER := true

# mds / multidislayservice
TARGET_HAS_MULTIPLE_DISPLAY := true
USE_MDS_LEGACY := true
USE_INTEL_MDP := true

# DRM Protected Video
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 1

# enable ARM codegen for x86 with Houdini
BUILD_ARM_FOR_X86 := true
INTEL_HOUDINI := true

# Appends path to ARM libs for Houdini
PRODUCT_LIBRARY_PATH := $(PRODUCT_LIBRARY_PATH):/system/lib/arm

# Radio
BOARD_RIL_SUPPORTS_MULTIPLE_CLIENTS := true
BOARD_RIL_CLASS := ../../../device/asus/a400cg/ril

# Adb
BOARD_FUNCTIONFS_HAS_SS_COUNT := true

# Init
TARGET_IGNORE_RO_BOOT_SERIALNO := true

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

#healtd
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BOARD_CHARGER_SHOW_PERCENTAGE := true

TARGET_OTA_ASSERT_DEVICE := ASUS_T00I,WW_ZenFone,a400cg

TARGET_SYSTEM_PROP := device/asus/a400cg/system.prop

