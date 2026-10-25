# CyanogenMod 12.1 for ASUS ZenFone 4 (A400CG / T00I)

<p align="center">
  <img src="https://raw.githubusercontent.com/CyanogenMod/android_vendor_cm/cm-12.1/prebuilt/common/bootanimation/480/part0/00000.png" alt="CyanogenMod 12.1" width="160" onerror="this.style.display='none'"/>
</p>

<p align="center">
  <a href="https://android.com"><img src="https://img.shields.io/badge/Android-5.1.1_r38_Lollipop-green.svg?style=flat-square&logo=android" alt="Android Version"/></a>
  <a href="https://github.com/CyanogenMod"><img src="https://img.shields.io/badge/ROM-CyanogenMod_12.1-blue.svg?style=flat-square" alt="CyanogenMod 12.1"/></a>
  <img src="https://img.shields.io/badge/Device-ASUS_ZenFone_4_(A400CG)-orange.svg?style=flat-square" alt="Device"/>
  <img src="https://img.shields.io/badge/Arch-Intel_x86_(Clover_Trail+)-red.svg?style=flat-square&logo=intel" alt="SoC"/>
  <img src="https://img.shields.io/badge/Status-Stable_/_Bringup_Complete-brightgreen.svg?style=flat-square" alt="Status"/>
  <img src="https://img.shields.io/badge/Maintainer-Sasha_Palamaryuk_(CatN10r)-purple.svg?style=flat-square" alt="Maintainer"/>
  <img src="https://img.shields.io/badge/License-Apache_2.0_/_GPL_v2-lightgrey.svg?style=flat-square" alt="License"/>
</p>

<p align="center">
  <b>English</b> | <a href="README_RU.md">Русский</a>
</p>

---

## 📖 Overview

This repository contains the complete device tree, proprietary vendor blobs, customized Linux Kernel 3.10 source, and system patchset required to build **CyanogenMod 12.1 (Android 5.1.1 Lollipop)** for the **ASUS ZenFone 4 (A400CG / A400CXG / T00I)** smartphone.

All long-standing hardware and platform issues associated with Intel Cloverview Z2520 (x86) on Android 5.x have been **fully resolved and verified on real hardware**:
* **Audio Subsystem:** Realtek ALSA RT5640 dual-channel Class-D amplifier routing resolved (rear loudspeaker on left channel `Ext Spk L`, front earpiece receiver on right channel `Ext Spk R`).
* **Telephony & In-Call Voice:** Full-duplex conversational voice call path operational (`AUDIO_MODE_IN_COMMUNICATION`), with simultaneous earpiece receiver output and conversational mic capture.
* **3.5mm Wired Headset Jack:** Automatic jack insertion/removal detection (`h2w`), wired headset button input mapping (`headset_dev.kl`), microphone recording routed via Parameter-Framework, and a persistent status bar headset indicator.
* **Wi-Fi Connectivity:** Resolved Broadcom BCM43362 AP association failures by handling `BCME_BUFTOOSHORT` in the kernel driver and falling back cleanly to `WLC_SET_SSID`.
* **Camera & Video:** Fixed AtomISP CSS2300 photo capture and video recording with synchronous, real-time audio playback without initial video stutter.
* **User Interface & Power:** Fixed lockscreen Keyguard black background via automatic wallpaper synchronization, calibrated battery full charging LED (green activates strictly at 100%), and disabled software navigation bar in favor of hardware capacitive touch keys.

---

## 📱 Device Specifications

| Specification | Details |
| :--- | :--- |
| **Model** | ASUS ZenFone 4 (`A400CG` / `A400CXG` / `T00I`) |
| **Codename** | `redhookbay` / `clovertrail` / `a400cg` |
| **SoC** | Intel Atom Z2520 (Clover Trail+ / Saltwell, 32-bit x86, 2 cores / 4 threads @ 1.2 GHz) |
| **GPU** | Imagination Technologies PowerVR SGX544 MP2 (EGL 1.4, GLES 2.0, OpenCL) |
| **RAM** | 1 GB LPDDR2 RAM |
| **Storage** | 8 GB eMMC + MicroSD slot (up to 64 GB) |
| **Display** | 4.0 inches, 800x480 (WVGA), 233 ppi, Himax HX8528 capacitive touchscreen |
| **Audio** | Realtek RT5640 I2S ALSA Codec + Intel Cloverview SST DSP |
| **Wireless** | Wi-Fi 802.11 b/g/n (Broadcom BCM43362), Bluetooth 4.0 EDR/LE, GPS/A-GPS (Broadcom BCM4752) |
| **Cameras** | Rear: 5.0 MP PixelMaster (AtomISP CSS2300), Front: 0.3 MP VGA |
| **Battery** | 1600 mAh / 1200 mAh (Li-Ion, removable) |

---

## 🛠 Hardware Support Status

| Component | Status | Technical Details |
| :--- | :---: | :--- |
| **Display & Touchscreen** | ✅ **Working** | Himax HX8528, 5-point multitouch. Mouse pointer cursor eliminated via `.idc` files. |
| **Hardware Graphics (PowerVR SGX544)** | ✅ **Working** | Hardware-accelerated UI, SurfaceFlinger, OpenGL ES 2.0, and HWC composition. |
| **Audio: Loudspeaker** | ✅ **Working** | Rear speaker via Realtek RT5640 Class-D amplifier left channel (`Ext Spk L`). |
| **Audio: Earpiece Receiver** | ✅ **Working** | Front conversational speaker via Realtek RT5640 right channel (`Ext Spk R`). |
| **Audio: Microphone** | ✅ **Working** | Primary mic capture, verified in conversational telephony mode (`AUDIO_MODE_IN_COMMUNICATION`). |
| **Wired Headset (3.5mm)** | ✅ **Working** | Jack switch event handling (`h2w`), headset mic recording, inline button (`headset_dev.kl`), and persistent status bar icon. |
| **Wi-Fi (BCM43362)** | ✅ **Working** | WPA/WPA2-PSK network scanning, authentication, and DHCP lease renewal (`dhcpcd`). |
| **Bluetooth (BCM43362)** | ✅ **Working** | BlueZ/Bluedroid stack, A2DP audio streaming, peripheral pairing and discovery. |
| **Cameras (AtomISP CSS2300)** | ✅ **Working** | Photo shooting and video recording with synchronous sound in stock Camera app. |
| **Hardware Video Codecs (OMX)** | ✅ **Working** | Smooth hardware decoding of H.264, MPEG-4, and VP8 via PowerVR VED video driver. |
| **GPS & Location Services** | ✅ **Working** | Native `gpsd` daemon communicating with kernel port `hsu_gps_port_p`. |
| **Vibration Motor** | ✅ **Working** | PCI vibrator driver `intel_vibra_driver` (`0000:00:06.6`) with userspace HAL timer. |
| **Battery & Charging LED** | ✅ **Working** | Charging indicator: steady orange; green indicator turns on strictly at 100% capacity. |
| **Lockscreen (Keyguard)** | ✅ **Working** | Eliminated black wallpaper issue; synchronized homescreen wallpaper to lockscreen backdrop. |
| **Capacitive Navigation Keys** | ✅ **Working** | Hardware Back, Home, and Menu capacitive keys active; software navigation bar hidden (`qemu.hw.mainkeys=1`). |
| **Houdini ARM Binary Translator** | ✅ **Working** | Transparent translation of ARMv7 native binaries to x86 for application and game compatibility. |

---

## 📂 Source Code & Tree Layout

```
a400cg_cm12.1_source/
├── README.md                          # English project documentation
├── README_RU.md                       # Russian project documentation
├── apply_patches.sh                   # Automated shell script to apply all 17 system patches
├── build.sh                           # One-click build script (mka bacon)
├── local_manifests/
│   └── a400cg.xml                     # Repo manifest for automated dependency synchronization
├── device/
│   └── asus/
│       └── a400cg/                    # Standalone Git repository for ASUS A400CG device tree
│           ├── audio/                 # ALSA sound configurations and Audio Policy
│           ├── keylayout/             # Keylayout mappings and headset button (headset_dev.kl)
│           ├── rootdir/               # Init scripts, fstab, ueventd, sbin binaries
│           ├── sepolicy/              # SELinux domain definitions (including houdini.te)
│           ├── BoardConfig.mk         # Board compilation flags, partition sizes, kernel config
│           ├── cm.mk                  # CyanogenMod product definition
│           ├── device.mk              # Package definitions and build copy rules
│           └── system.prop            # System properties (maintainer branding, navigation keys)
├── vendor/
│   ├── asus/
│   │   └── a400cg/                    # Proprietary blobs, AtomISP firmware, Parameter-Framework XML
│   └── intel/
│       ├── bootstub/              # x86 Bootstub loader repository
│       └── houdini/               # ARM-to-x86 binary translation system
├── linux/
│   └── kernel/                        # Linux Kernel 3.10.20 repository with all A400CG patches
├── hardware/
│   └── intel/
│       └── sensors/                   # IIO Sensors HAL repository
└── patches/                           # 17 unified Git patches for CyanogenMod 12.1 core repos
    ├── 01_build.patch                 # OpenJDK 8, OSIP partition support, and build properties
    ├── 02_system_core.patch           # FunctionFS SS_COUNT descriptors for Intel Penwell/ADB
    ├── 03_frameworks_base.patch       # Headset icon, Keyguard wallpaper sync, 100% LED threshold
    ├── 04_frameworks_av.patch         # cm_audiotest native hardware diagnostic utility
    ├── 05_frameworks_support.patch    # Compilation fixes for Android Support Library v4
    ├── 06_hardware_libhardware_legacy.patch # Fallback timer for Cloverview PCI vibrator
    ├── 07_hardware_intel_libmix.patch # Parser header inclusion for libmixvbp
    ├── 08_hardware_intel_omx-components.patch # Suppress Werror for Cloverview video codecs
    ├── 09_hardware_intel_psb_headers.patch # DRM/WV header exports
    ├── 10_hardware_intel_psb_video.patch # USE_MDS_LEGACY flag for PowerVR video driver
    ├── 11_external_wpa_supplicant_8.patch # nl80211 driver adjustments for bcmdhd
    ├── 12_external_chromium_org.patch # Python 3 and regex build compatibility
    ├── 13_external_chromium_org_third_party_WebKit.patch # Bison parser rule compatibility
    ├── 14_external_guava.patch        # Splitter compatibility with OpenJDK 8
    ├── 15_libcore.patch               # EnumMap compatibility with OpenJDK 8
    ├── 16_packages_apps_Camera2.patch # OneCameraManager fallback
    └── 17_packages_apps_Settings.patch # Display ROM maintainer in "About phone"
```

---

## 🔨 Build Instructions

### 1. Prerequisites (Ubuntu 18.04 - 22.04 LTS)
Install required build dependencies:
```bash
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev \
  x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip \
  python2 python-is-python2 schedtool libssl-dev bc
```

### 2. Initialize the CyanogenMod 12.1 Source Tree
```bash
mkdir -p ~/android/cm12.1
cd ~/android/cm12.1
repo init -u https://github.com/CyanogenMod/android.git -b cm-12.1
```

### 3. Add Device Manifest & Sync Sources
Copy the local manifest into `.repo/local_manifests/`:
```bash
mkdir -p .repo/local_manifests
cp /path/to/a400cg_cm12.1_source/local_manifests/a400cg.xml .repo/local_manifests/
repo sync -c -j$(nproc) --force-sync --no-clone-bundle
```
*(Alternatively, extract `device/`, `vendor/`, `linux/`, and `hardware/` directly into the CM 12.1 root directory).*

### 4. Apply System Patches
Run the automated patching script:
```bash
/path/to/a400cg_cm12.1_source/apply_patches.sh
```

### 5. Compile the ROM
```bash
source build/envsetup.sh
lunch cm_a400cg-userdebug
mka bacon
```
*(Or simply execute `./build.sh` from the root of the source tree).*

Upon completion, the signed flashable zip (`cm-12.1-*-UNOFFICIAL-a400cg.zip`), `boot.img`, and `system.img` will be generated in:
`out/target/product/a400cg/`

---

## 📦 Flashing Guide

### Method 1: Recovery Installation (TWRP / CWM)
1. Copy `cm-12.1-20261025-UNOFFICIAL-a400cg.zip` to a MicroSD card.
2. Boot into Recovery mode (power off, hold `Volume Up` + `Power`, select **Recovery**).
3. Perform a **Wipe Data / Factory Reset** and clear Cache / Dalvik.
4. Select **Install zip from sdcard** and confirm installation.
5. Reboot into the system.

### Method 2: Fastboot / Droidboot Installation
Boot the device into Droidboot mode (hold `Volume Up` + `Power`), connect USB, and execute:
```bash
fastboot flash boot boot.img
fastboot flash system system.img
fastboot reboot
```

---

## 📥 Prebuilt Downloads

Official build artifacts for the release:

| File | Description | Size | MD5 Checksum |
| :--- | :--- | :---: | :--- |
| **`cm-12.1-20261025-UNOFFICIAL-a400cg.zip`** | Full Flashable ROM ZIP for TWRP/CWM | 315 MB | `bf531a2dcd25aa8dfe14e67ed51b1d52` |
| **`boot.img`** | Kernel 3.10 + Ramdisk with `.ko` modules | 8.0 MB | `285e9d8b70e39da0d6ac0664847888c0` |
| **`system.img`** | Ext4 sparse system partition image | 665 MB | `95b88b8b1c8142261855d9a8b64c241d` |
| **`a400cg_cm12.1_source_20261025.tar.gz`** | Complete standalone source code archive | 537 MB | `1f4d144b5a9b306b2dd9dfd4cf1c50d0` |

---

## 👨‍💻 Maintainer & Credits

* **Port Developer & Maintainer:** **Sasha Palamaryuk ([CatN10r](https://github.com/CatN10r))**
* **AI Engineering & Research Assistants:**
  * **Gemini 3.8 Flash** — real-time kernel diagnostics, rapid log analysis, and system patch generation.
  * **Gemini 4 Argon** — architecture synthesis, hardware bringup strategy, and deep driver debugging.
  * **Claude Sonnet 5.5** — advanced code refactoring, logic auditing, and bringup verification.
* **CyanogenMod Community:** for the open-source CM 12.1 Android platform.
* **artefvck:** for initial device tree and kernel bringup groundwork.
* **Intel Corporation & ASUS:** for the Cloverview hardware reference and original stock software.

---

## 📜 License
* Android and CyanogenMod components are licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
* The Linux Kernel is licensed under the [GNU General Public License v2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).
* Proprietary blobs and firmware are property of ASUSTeK Computer Inc., Intel Corporation, and Broadcom Corporation.
