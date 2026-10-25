#!/bin/sh -x
#This is balance mode

echo 99 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
echo 1000000 > /sys/devices/system/cpu/cpufreq/interactive/touchboost_freq
echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/touchboostpulse_duration
echo 90 1000000:95 > /sys/devices/system/cpu/cpufreq/interactive/target_loads

