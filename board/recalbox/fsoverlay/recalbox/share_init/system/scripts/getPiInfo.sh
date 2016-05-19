#!/bin/bash
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
echo Raspberry Temperatures:
echo -----------------------
echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"
echo GPU $(vcgencmd measure_temp)

echo Raspberry Pi SysInfo:
echo ---------------------
MHZ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
TEMPE=$(cat /sys/class/thermal/thermal_zone0/temp)

echo Hardware:
# echo Current CPU Speed $(($MHZ/1000)) Mhz "|" CPU Temp $(($TEMPE/1000)) C
echo Current CPU Speed $(($MHZ/1000)) Mhz "|" CPU Temp "="$cpuTemp1"."$cpuTempM"'C"

echo Raspberry Pi Configuration:
echo ---------------------------
vcgencmd get_config int

echo Raspberry Pi Clocks:
echo --------------------
for src in arm core h264 isp v3d uart pwm emmc pixel vec hdmi dpi ; do echo -e "$src:\t$(vcgencmd measure_clock $src)" ; done
