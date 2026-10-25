HAVE_SELINUX := true

BOARD_SEPOLICY_DIRS += device/asus/a400cg/sepolicy

BOARD_SEPOLICY_UNION += \
              file_contexts \
              property_contexts \
              seapp_contexts \
              service_contexts \
              find.py \
              fs_use \
              genfs_contexts \
              adbd.te \
              akmd.te \
              apk_logfs.te \
              bcu_cpufreqrel.te \
              bluetooth.te \
              crashlogd.te \
              device.te \
              ecryptfs.te \
              fg_conf.te \
              file.te \
              gpsd.te \
              houdini.te \
              healthd.te \
              init.te \
              init_shell.te \
              install_recovery.te \
              isolated_app.te \
              kernel.te \
              keystore.te \
              logcat.te \
              logd.te \
              logtoold.te \
              mediaserver.te \
              mmgr.te \
              netd.te \
              nvm_server.te \
              platform_app.te \
              property.te \
              pvrsrvctl.te \
              radio.te \
              rild.te \
              sysinit.te \
              sdcardd.te \
              service.te \
              servicemanager.te \
              shell.te \
              su.te \
              sudaemon.te \
              surfaceflinger.te \
              system_app.te \
              system_server.te \
              ueventd.te \
              untrusted_app.te \
              upi_ug31xx.te \
              vdc.te \
              vold.te \
              wlan_prov.te \
              wpa.te \
              zygote.te
