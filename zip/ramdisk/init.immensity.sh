#!/system/bin/sh
#
# File Type      : Ramdisk Script
# Github         : UtsavisGreat <utsavbalar1231@gmail.com>
# xda-developers : UtsavTheGreat
# Kernel name    : IMMENSITY

setimmensityConfig() {

# IO block tweaks for better system performance;
for i in /sys/block/*/queue; do
  echo "0" > $i/add_random;
  echo "0" > $i/iostats;
  echo "0" > $i/nomerges;
  echo "96" > $i/nr_requests;
  echo "128" > $i/read_ahead_kb;
  echo "0" > $i/rotational;
  echo "1" > $i/rq_affinity;
done;

# Tweak and decrease tx_queue_len default stock value(s) for less amount of generated bufferbloat and for gaining slightly faster network speed and performance;
for i in $(find /sys/class/net -type l); do
  echo "128" > $i/tx_queue_len;
done;

echo "0" > /sys/module/msm_thermal/core_control/enabled

# Set Max-Frequency
echo "2016000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "652800" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

echo "1" > /sys/module/msm_thermal/core_control/enabled

# Disable slice_idle on supported block devices
for block in mmcblk0 mmcblk1 dm-0 dm-1 sda; do
    echo "0" > /sys/block/$block/queue/iosched/slice_idle
done;

# configure governor settings for little cluster
echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# A couple of minor kernel entropy tweaks & enhancements for a slight UI responsivness boost;
echo "128" > /proc/sys/kernel/random/read_wakeup_threshold
echo "96" > /proc/sys/kernel/random/urandom_min_reseed_secs
echo 1024 > /proc/sys/kernel/random/write_wakeup_threshold

# Set read ahead to 128 kb for external storage
# The rest are handled by qcom-post-boot
echo "128" > /sys/block/mmcblk1/queue/read_ahead_kb

# FileSystem (FS) optimized tweaks & enhancements for a improved userspace experience;
echo "0" > /proc/sys/fs/dir-notify-enable
echo "30" > /proc/sys/fs/lease-break-time

# Marginally reduce suspend latency
echo "1" > /sys/module/printk/parameters/console_suspend


}

setimmensityConfig &
