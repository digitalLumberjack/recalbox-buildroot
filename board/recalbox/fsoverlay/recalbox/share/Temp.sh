#!/bin/bash
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
CpuSpeedCurrent=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
#echo $CpuSpeedCurrent
CpuSpeedMin=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq)
#echo $CpuSpeedMin
CpuSpeedMax=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)
#echo $CpuSpeedMax
CpuSpeedCurrent1=$(($CpuSpeedCurrent/1000))
CpuSpeedMin1=$(($CpuSpeedMin/1000))
CpuSpeedMax1=$(($CpuSpeedMax/1000))
echo Raspberry Temperatures:
echo -----------------------
echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"
echo Raspberry Speed:
echo ----------------
echo Current Speed : $CpuSpeedCurrent1 MHz
echo Minimum Speed : $CpuSpeedMin1 MHz
echo Maximum Speed : $CpuSpeedMax1 MHz
