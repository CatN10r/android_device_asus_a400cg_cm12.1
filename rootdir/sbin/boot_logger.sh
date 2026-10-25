#!/system/bin/sh
# Autonomous early boot diagnostic logger to /cache (/dev/block/mmcblk0p6)
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin

# Ensure /cache is mounted rw even if mount_all partially failed
mount -t ext4 -o rw,nosuid,nodev,noatime,barrier=1,data=ordered /dev/block/mmcblk0p6 /cache 2>/dev/null

# Preserve previous boot logs for comparison in TWRP
[ -f /cache/boot_dmesg.log ] && mv /cache/boot_dmesg.log /cache/boot_dmesg.prev.log
[ -f /cache/boot_logcat.log ] && mv /cache/boot_logcat.log /cache/boot_logcat.prev.log

# Capture any persistent pstore / emmc_ipanic crash logs from previous reset
{
    echo "=== PREVIOUS CRASH / PANIC DUMPS ==="
    for f in /sys/fs/pstore/console-ramoops /proc/last_kmsg /proc/emmc_ipanic_console /proc/apanic_console; do
        if [ -e "$f" ]; then
            echo "--- $f ---"
            cat "$f" 2>&1
        fi
    done
} > /cache/boot_last_panic.log 2>&1

# Reinforce BCB zeroing on /dev/block/mmcblk0p4 (spare/misc) and SCU OSNIB watchdog reset
dd if=/dev/zero of=/dev/block/mmcblk0p4 bs=4096 count=16 2>/dev/null
echo 0 > /sys/devices/virtual/misc/watchdog/counter 2>/dev/null
echo 1 > /sys/devices/virtual/misc/watchdog/disable 2>/dev/null

# Periodically snapshot dmesg + boot state every 2s with atomic rename + sync
i=0
while [ $i -lt 150 ]; do
    {
        echo "=== BOOT SNAPSHOT #$i | uptime: $(cat /proc/uptime) ==="
        echo "cmdline: $(cat /proc/cmdline)"
        echo "SELinux enforce: $(cat /sys/fs/selinux/enforce 2>/dev/null) | ro.boot.selinux=$(getprop ro.boot.selinux) | bootmode=$(getprop ro.boot.mode)"
        echo "init services (running/restarting/stopped):"
        getprop | grep -E "init\.svc\.|sys\.boot_completed|vold\.decrypt|service\.bootanim|usb"
        echo "USB state: $(cat /sys/class/android_usb/android0/state 2>/dev/null) | enable=$(cat /sys/class/android_usb/android0/enable 2>/dev/null) | funcs=$(cat /sys/class/android_usb/android0/functions 2>/dev/null)"
        echo "GPU & USB dev nodes:"
        ls -la /dev/card0 /dev/pvr_sync /dev/dri /dev/usb-ffs/adb 2>&1
        echo "Loaded kernel modules (lsmod):"
        cat /proc/modules 2>&1
        echo "=== MOUNTS ==="
        cat /proc/mounts
        echo "=== DMESG ==="
        dmesg
    } > /cache/boot_dmesg.tmp 2>&1
    mv /cache/boot_dmesg.tmp /cache/boot_dmesg.log
    chmod 0644 /cache/boot_dmesg.log /cache/boot_logcat.log /cache/boot_last_panic.log 2>/dev/null
    sync

    if [ "$(getprop sys.boot_completed)" = "1" ]; then
        break
    fi
    i=$((i + 1))
    sleep 2
done
