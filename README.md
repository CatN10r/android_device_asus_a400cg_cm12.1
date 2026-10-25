# CyanogenMod 12.1 Source Code for ASUS ZenFone 4 (A400CG / T00I)

Официальный исходный код прошивки **CyanogenMod 12.1 (Android 5.1.1 Lollipop)** для смартфона **ASUS ZenFone 4 (A400CG / A400CXG / T00I)** со всеми аппаратными исправлениями и доработками.

* **Автор и мейнтейнер:** Sasha Palamaryuk (CatN10r)
* **Целевое устройство:** ASUS ZenFone 4 (A400CG / T00I / redhookbay)
* **Платформа / SoC:** Intel Atom Z2520 (Clover Trail+ / Saltwell, 2x 1.2 GHz)
* **Аудиокодек:** Realtek ALSA RT5640 (Ext Spk L: задний динамик, Ext Spk R: разговорный динамик)
* **Wi-Fi / Bluetooth:** Broadcom BCM43362 (SDIO + UART ttyMFD0)
* **Графика:** Imagination PowerVR SGX544MP2 (EGL 1.4, GLES 2.0, OpenCL)
* **Ядро:** Linux Kernel 3.10.20 (Intel Cloverview BSP)

---

## 1. Статус аппаратной поддержки (Bringup Status)

| Подсистема | Статус | Примечания |
| :--- | :---: | :--- |
| **Сенсорный экран** | **Работает** | Himax HX8528, мультитач 5 точек, курсор мыши устранён (`.idc`) |
| **Графика и UI** | **Работает** | PowerVR SGX544, аппаратный рендеринг, без задержек |
| **Wi-Fi** | **Работает** | Broadcom BCM43362, WPA2, DHCP, сканирование и автоподключение |
| **Bluetooth** | **Работает** | A2DP, поиск и сопряжение беспроводных наушников/устройств |
| **Звук (Speaker)** | **Работает** | Задний громкоговоритель (ALSA RT5640, левый канал) |
| **Звук (Earpiece)** | **Работает** | Фронтальный разговорный динамик (ALSA RT5640, правый канал) |
| **Микрофон (Mic)** | **Работает** | Разговорный микрофон, проверен в дуплексном телефонном вызове |
| **Наушники / Гарнитура** | **Работает** | Автоопределение штекера (`h2w`), запись с гарнитурного микрофона, раскладка кнопки гарнитуры (`headset_dev.kl`), постоянная иконка в статус-баре |
| **Камера (AtomISP)** | **Работает** | Фотосъёмка и видеосъёмка, звук в видео пишется без отставания |
| **Видеодекодеры (OMX)** | **Работает** | Аппаратное ускорение H.264/MPEG4/VP8 через PowerVR/VED |
| **Экран блокировки** | **Работает** | Обои Keyguard автоматически синхронизируются с рабочим столом |
| **Светодиод зарядки (LED)** | **Работает** | Зелёный цвет загорается строго при 100% уровня заряда батареи |
| **Вибрация** | **Работает** | Драйвер `intel_vibra_driver` (PCI `0000:00:06.6`) |
| **Аппаратные кнопки** | **Работает** | Сенсорные клавиши назад/домой/меню, наэкранный бар скрыт |
| **Houdini (ARM->x86)** | **Работает** | Прозрачная трансляция ARMv7 бинарников и игр в x86 |

---

## 2. Структура архива исходного кода

```
a400cg_cm12.1_source/
├── README.md                      # Данный документ
├── apply_patches.sh               # Скрипт автоматического применения патчей к исходникам CM 12.1
├── build.sh                       # Скрипт сборки одной командой (mka bacon)
├── local_manifests/
│   └── a400cg.xml                 # Манифест для загрузки зависимостей через repo sync
├── device/
│   └── asus/
│       └── a400cg/                # Дерево устройства ASUS A400CG (Git-репозиторий)
├── vendor/
│   ├── asus/
│   │   └── a400cg/                # Проприетарные блобы, XML Parameter-Framework (Git-репозиторий)
│   └── intel/
│       ├── bootstub/              # x86 Bootstub загрузчик (Git-репозиторий)
│       └── houdini/               # Двоичный транслятор ARM-приложений (Git-репозиторий)
├── linux/
│   └── kernel/                    # Исходный код ядра Linux 3.10 со всеми правками (Git-репозиторий)
├── hardware/
│   └── intel/
│       └── sensors/               # IIO Sensors HAL (Git-репозиторий)
└── patches/                       # 17 патчей для базовых компонентов CyanogenMod/AOSP
    ├── 01_build.patch
    ├── 02_system_core.patch
    ├── 03_frameworks_base.patch
    ├── 04_frameworks_av.patch
    ├── 05_frameworks_support.patch
    ├── 06_hardware_libhardware_legacy.patch
    ├── 07_hardware_intel_libmix.patch
    ├── 08_hardware_intel_omx-components.patch
    ├── 09_hardware_intel_psb_headers.patch
    ├── 10_hardware_intel_psb_video.patch
    ├── 11_external_wpa_supplicant_8.patch
    ├── 12_external_chromium_org.patch
    ├── 13_external_chromium_org_third_party_WebKit.patch
    ├── 14_external_guava.patch
    ├── 15_libcore.patch
    ├── 16_packages_apps_Camera2.patch
    └── 17_packages_apps_Settings.patch
```

---

## 3. Инструкция по сборке из исходного кода

### Шаг 1: Инициализация дерева CyanogenMod 12.1
```bash
mkdir cm12.1
cd cm12.1
repo init -u https://github.com/CyanogenMod/android.git -b cm-12.1
```

### Шаг 2: Добавление локального манифеста
Скопируйте `local_manifests/a400cg.xml` в каталог `.repo/local_manifests/`:
```bash
mkdir -p .repo/local_manifests
cp /path/to/a400cg_cm12.1_source/local_manifests/a400cg.xml .repo/local_manifests/
repo sync -c -j8
```

*Либо скопируйте каталоги `device/`, `vendor/`, `linux/` и `hardware/` напрямую из данного архива в корень дерева CM 12.1.*

### Шаг 3: Применение системных патчей
Запустите скрипт автоматического применения патчей:
```bash
/path/to/a400cg_cm12.1_source/apply_patches.sh
```

### Шаг 4: Запуск сборки
```bash
source build/envsetup.sh
lunch cm_a400cg-userdebug
mka bacon
```
*Либо запустите скрипт `build.sh` из корня дерева.*

Готовый установочный ZIP-архив (`cm-12.1-*-UNOFFICIAL-a400cg.zip`), а также образы `boot.img` и `system.img` будут созданы в папке `out/target/product/a400cg/`.

---

## 4. Авторство и благодарности
* **Мейнтейнер / Разработчик порта:** Sasha Palamaryuk (CatN10r)
* **Базовые репозитории и BSP:** artefvck, CyanogenMod team, Intel Android Open Source Project.
