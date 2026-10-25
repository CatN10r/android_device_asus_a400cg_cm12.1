## Specify phone tech before including full_phone
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH := 480
# Release name
PRODUCT_RELEASE_NAME := a400cg

# Override CM default audio_effects.conf with stock ASUS V7.3.3 audio_effects.conf
# (Must precede common_full_phone.mk because first PRODUCT_COPY_FILES entry wins)
PRODUCT_COPY_FILES += \
    vendor/asus/a400cg/proprietary/system/etc/audio_effects.conf:system/etc/audio_effects.conf

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration change remove aosp full
$(call inherit-product, device/asus/a400cg/aosp_a400cg.mk)

PRODUCT_RUNTIMES := runtime_libart_default

PRODUCT_NAME := cm_a400cg
PRODUCT_BRAND := asus
PRODUCT_MODEL := ASUS_T00I
PRODUCT_MANUFACTURER := asus
PRODUCT_DEVICE := a400cg

PRODUCT_GMS_CLIENTID_BASE := android-asus


TARGET_VENDOR_PRODUCT_NAME := WW_ZenFone
TARGET_VENDOR_DEVICE_NAME := ASUS_T00I
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=ASUS_T00I PRODUCT_NAME=WW_ZenFone

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=WW_ZenFone \
    BUILD_FINGERPRINT=asus/WW_ZenFone/ASUS_T00I:5.0/LRX21V/WW_ZenFone-V7.4.4-20150831:user/release-keys \
    PRIVATE_BUILD_DESC="WW_ZenFone-user 5.0 LRX21V WW_ZenFone-V7.4.4-20150831 release-keys"

