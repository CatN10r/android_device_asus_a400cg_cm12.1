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
  <a href="README.md">English</a> | <b>Русский</b>
</p>

---

## 📖 О проекте / Overview

Данный репозиторий содержит полный исходный код, дерево устройства (`device tree`), проприетарные библиотеки (`vendor blobs`), исходный код ядра Linux 3.10 и набор системных патчей для сборки **CyanogenMod 12.1 (Android 5.1.1 Lollipop)** для смартфона **ASUS ZenFone 4 (A400CG / A400CXG / T00I)**.

Все ключевые аппаратные проблемы платформы Intel Cloverview Z2520, характерные для ранних портов Lollipop, были **полностью устранены и отлажены на живом устройстве**:
* Восстановлена работа двухканального аудиокодека Realtek ALSA RT5640 (разговорный и мультимедийный динамики разделены по аппаратно независимым каналам).
* Полностью реализован дуплексный режим телефонных звонков (In-Call Voice Stream + микрофон).
* Подключена поддержка проводной гарнитуры: автоматическое переключение звука, перехват кнопки гарнитуры (`headset_dev.kl`), запись с внешнего микрофона и постоянный индикатор подключения в строке состояния.
* Устранена проблема ассоциации Wi-Fi BCM43362 (обход `BCME_BUFTOOSHORT` в ядре с падением на `WLC_SET_SSID`).
* Устранена задержка отображения видео при воспроизведении и синхронизирована звуковая дорожка при видеозаписи (AtomISP / PowerVR VED).
* Исправлен чёрный экран блокировки (Keyguard backdrop) и откалиброван светодиод полной зарядки аккумулятора (зелёный цвет строго при 100%).

---

## 📱 Характеристики устройства / Specifications

| Параметр | Значение |
| :--- | :--- |
| **Модель** | ASUS ZenFone 4 (`A400CG` / `A400CXG` / `T00I`) |
| **Кодовое имя** | `redhookbay` / `clovertrail` / `a400cg` |
| **Процессор (SoC)** | Intel Atom Z2520 (Clover Trail+ / Saltwell, 32-bit x86, 2 ядра / 4 потока @ 1.2 GHz) |
| **Графика (GPU)** | Imagination Technologies PowerVR SGX544 MP2 (EGL 1.4, GLES 2.0, OpenCL) |
| **Оперативная память** | 1 GB LPDDR2 RAM |
| **Флеш-память** | 8 GB eMMC + поддержка карт памяти MicroSD (до 64 GB) |
| **Экран** | 4.0 дюйма, 800x480 (WVGA), 233 ppi, емкостной тачскрин Himax HX8528 |
| **Аудио** | Realtek RT5640 I2S ALSA Codec + Intel Cloverview SST DSP |
| **Связь** | Wi-Fi 802.11 b/g/n (Broadcom BCM43362), Bluetooth 4.0 EDR/LE, GPS/A-GPS (Broadcom BCM4752) |
| **Камеры** | Основная: 5.0 MP PixelMaster (AtomISP CSS2300), Фронтальная: 0.3 MP VGA |
| **Батарея** | 1600 mAh / 1200 mAh (Li-Ion, съемная) |

---

## 🛠 Статус аппаратного обеспечения / Hardware Status

| Модуль | Статус | Детали реализации |
| :--- | :---: | :--- |
| **Экран и Тачскрин** | ✅ **Работает** | Himax HX8528, 5-точечный мультитач. Курсор мыши отключён через `.idc` конфигурации. |
| **Графика (PowerVR SGX544)** | ✅ **Работает** | Аппаратный рендеринг GUI, SurfaceFlinger, аппаратная композиция HWC. |
| **Звук: Мультимедиа** | ✅ **Работает** | Задний громкий динамик (Realtek RT5640, левый канал Class-D усилителя `Ext Spk L`). |
| **Звук: Разговорный динамик** | ✅ **Работает** | Фронтальный спикер (Realtek RT5640, правый канал Class-D усилителя `Ext Spk R`). |
| **Звук: Микрофон** | ✅ **Работает** | Встроенный разговорный микрофон, проверен в дуплексе вызова (`AUDIO_MODE_IN_COMMUNICATION`). |
| **Проводная гарнитура (3.5 мм)** | ✅ **Работает** | Детекция штекера (`h2w`), запись звука с гарнитуры, кнопка гарнитуры, постоянная иконка в статус-баре. |
| **Wi-Fi (BCM43362)** | ✅ **Работает** | Сканирование сетей, стабильное подключение WPA/WPA2-PSK, работа службы DHCP (`dhcpcd`). |
| **Bluetooth (BCM43362)** | ✅ **Работает** | BlueZ/Bluedroid стек, профили A2DP, сопряжение с аудиоустройствами и гарнитурами. |
| **Камера (AtomISP CSS2300)** | ✅ **Работает** | Фотосъёмка и видеозапись со звуком в штатном приложении Камера. |
| **Аппаратные видеодекодеры (OMX)** | ✅ **Работает** | Аппаратное воспроизведение H.264/MPEG4/VP8 через драйвер VED без задержек. |
| **GPS / Геолокация** | ✅ **Работает** | Демон `gpsd`, связь по порту ядра `hsu_gps_port_p`. |
| **Виброотклик** | ✅ **Работает** | PCI драйвер вибромотора `intel_vibra_driver` (`0000:00:06.6`) с HAL таймером. |
| **Светодиод уведомлений (LED)** | ✅ **Работает** | Зарядка: постоянный оранжевый, зелёный цвет загорается строго при 100% емкости. |
| **Экран блокировки (Keyguard)** | ✅ **Работает** | Устранён чёрный экран, настроена синхронизация обоев с домашним экраном. |
| **Сенсорные кнопки управления** | ✅ **Работает** | Сенсорные аппаратные клавиши (Назад / Домой / Меню), программный бар скрыт (`qemu.hw.mainkeys=1`). |
| **Houdini ARM Translator** | ✅ **Работает** | Прозрачная трансляция инструкций ARMv7 в x86 для совместимости с приложениями и играми. |

---

## 📂 Структура репозитория / Repository Tree

```
a400cg_cm12.1_source/
├── README.md                          # Данное руководство
├── apply_patches.sh                   # Скрипт автоматического применения 17 системных патчей
├── build.sh                           # Скрипт запуска полной сборки (mka bacon)
├── local_manifests/
│   └── a400cg.xml                     # Локальный манифест для утилиты repo
├── device/
│   └── asus/
│       └── a400cg/                    # Дерево устройства (ветка cm-12.1-a400cg)
│           ├── audio/                 # Конфигурации ALSA и Audio Policy
│           ├── keylayout/             # Раскладки клавиатуры и гарнитуры (headset_dev.kl)
│           ├── rootdir/               # Init-скрипты, fstab, ueventd, sbin
│           ├── sepolicy/              # Политики SELinux (включая houdini.te)
│           ├── BoardConfig.mk         # Сборочные флаги ядра, разделов и графики
│           ├── cm.mk                  # Параметры продукта CyanogenMod
│           ├── device.mk              # Список пакетов, модулей и файлов копирования
│           └── system.prop            # Свойства системы (авторство, экранные клавиши)
├── vendor/
│   ├── asus/
│   │   └── a400cg/                    # Проприетарные блобы и XML Parameter-Framework
│   └── intel/
│       ├── bootstub/                  # Загрузочный x86 стаб
│       └── houdini/                   # Двоичный транслятор ARM-приложений
├── linux/
│   └── kernel/                        # Исходный код ядра Linux 3.10.20 со всеми исправлениями
├── hardware/
│   └── intel/
│       └── sensors/                   # HAL аппаратных датчиков IIO
└── patches/                           # 17 унифицированных патчей для дерева CM 12.1
    ├── 01_build.patch                 # Поддержка OpenJDK 8, OSIP разделов, buildinfo
    ├── 02_system_core.patch           # FunctionFS SS_COUNT дескрипторы для Intel Penwell/ADB
    ├── 03_frameworks_base.patch       # Иконка гарнитуры, Keyguard обои, порог LED 100%
    ├── 04_frameworks_av.patch         # Утилита аппаратной диагностики cm_audiotest
    ├── 05_frameworks_support.patch    # Сборочные исправления v4 support library
    ├── 06_hardware_libhardware_legacy.patch # Fallback для вибромотора Cloverview PCI
    ├── 07_hardware_intel_libmix.patch # Заголовки медиапарсера для libmixvbp
    ├── 08_hardware_intel_omx-components.patch # Отключение Werror для Cloverview видеокодеков
    ├── 09_hardware_intel_psb_headers.patch # Экспорт DRM/WV заголовков
    ├── 10_hardware_intel_psb_video.patch # Флаг USE_MDS_LEGACY для PowerVR видеодрайвера
    ├── 11_external_wpa_supplicant_8.patch # Корректировка nl80211 под bcmdhd
    ├── 12_external_chromium_org.patch # Совместимость с современными версиями Python/Bison
    ├── 13_external_chromium_org_third_party_WebKit.patch
    ├── 14_external_guava.patch        # Совместимость Splitter с OpenJDK 8
    ├── 15_libcore.patch               # Совместимость EnumMap с OpenJDK 8
    ├── 16_packages_apps_Camera2.patch # OneCameraManager fallback
    └── 17_packages_apps_Settings.patch # Отображение мейнтейнера в «О телефоне»
```

---

## 🔨 Инструкция по сборке / Build Instructions

### 1. Подготовка сборочного окружения (Ubuntu 18.04 - 22.04 LTS)
Установите необходимые пакеты компиляции Android:
```bash
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev \
  x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip \
  python2 python-is-python2 schedtool libssl-dev bc
```

### 2. Инициализация репозитория CyanogenMod 12.1
```bash
mkdir -p ~/android/cm12.1
cd ~/android/cm12.1
repo init -u https://github.com/CyanogenMod/android.git -b cm-12.1
```

### 3. Добавление дерева устройства и манифеста
Скопируйте файл манифеста `a400cg.xml` в папку `.repo/local_manifests/`:
```bash
mkdir -p .repo/local_manifests
cp /path/to/a400cg_cm12.1_source/local_manifests/a400cg.xml .repo/local_manifests/
repo sync -c -j$(nproc) --force-sync --no-clone-bundle
```
*(Или скопируйте каталоги `device/`, `vendor/`, `linux/` и `hardware/` из архива исходников напрямую в корень дерева).*

### 4. Автоматическое применение системных патчей
Запустите скрипт применения патчей:
```bash
/path/to/a400cg_cm12.1_source/apply_patches.sh
```

### 5. Запуск компиляции
```bash
source build/envsetup.sh
lunch cm_a400cg-userdebug
mka bacon
```
*(Или просто запустите `./build.sh` из корня проекта).*

По завершении сборки готовые образы будут доступны в каталоге:
`out/target/product/a400cg/`

---

## 📦 Установка прошивки на смартфон / Installation

### Способ 1: Прошивка через кастомное рекавери (TWRP / CWM)
1. Скопируйте установочный ZIP-архив `cm-12.1-20261025-UNOFFICIAL-a400cg.zip` на карту памяти MicroSD.
2. Перезагрузите смартфон в режим Recovery (зажмите кнопки `Громкость Вверх` + `Питание`, затем выберите **Recovery**).
3. Выполните **Wipe Data / Factory Reset** и очистку разделов Cache / Dalvik.
4. Выберите **Install zip from sdcard** и выберите архив с прошивкой.
5. После завершения прошивки выполните **Reboot System**.

### Способ 2: Прошивка через Fastboot (Droidboot)
Переведите телефон в режим Droidboot и выполните команды на компьютере:
```bash
fastboot flash boot boot.img
fastboot flash system system.img
fastboot reboot
```

---

## 📥 Готовые сборки / Prebuilt Downloads

Файлы финального релиза:

| Файл | Описание | Размер | Контрольная сумма MD5 |
| :--- | :--- | :---: | :--- |
| **`cm-12.1-20261025-UNOFFICIAL-a400cg.zip`** | Готовый Flashable ZIP для TWRP | 315 MB | `bf531a2dcd25aa8dfe14e67ed51b1d52` |
| **`boot.img`** | Образ ядра Linux 3.10 + Ramdisk | 8.0 MB | `285e9d8b70e39da0d6ac0664847888c0` |
| **`system.img`** | Чистый образ раздела `/system` (ext4) | 665 MB | `95b88b8b1c8142261855d9a8b64c241d` |
| **`a400cg_cm12.1_source_20261025.tar.gz`** | Полный архив исходного кода | 537 MB | `fa3b845774c1195d46aaffd89f840192` |

---

## 👨‍💻 Авторы и благодарности / Credits

* **Разработчик порта и мейнтейнер:** **Sasha Palamaryuk ([CatN10r](https://github.com/CatN10r))**
* **Искусственный интеллект и инженерная помощь:**
  * **Gemini 3.8 Flash** — экспресс-анализ дампов ядра и логов, оперативная генерация системных патчей.
  * **Gemini 4 Argon** — системная архитектура, стратегия аппаратного bringup и глубокая отладка драйверов.
  * **Claude Sonnet 5.5** — глубокий аудит логики компонентов, рефакторинг кода и верификация узлов.
* **CyanogenMod Community:** за платформу CM 12.1 и открытый исходный код.
* **artefvck:** за исходные наработки дерева устройства и ядра.
* **Intel Corporation & ASUS:** за аппаратную платформу Intel Cloverview и стоковое ПО.

---

## 📜 Лицензия / License
* Компоненты Android/CyanogenMod лицензированы под [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
* Ядро Linux лицензировано под [GNU General Public License v2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).
* Проприетарные блобы принадлежат компаниям ASUSTeK Computer Inc., Intel Corporation и Broadcom Corporation.
