#!/bin/bash

# Загрузка CPU
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
if [ -z "$CPU_USAGE" ]; then
    CPU_USAGE=$(top -bn1 | grep "%Cpu" | awk '{print $2}')
fi
CPU_USAGE=${CPU_USAGE%.*}

# Температура CPU
if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
    CPU_TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
    CPU_TEMP=$((CPU_TEMP / 1000))
else
    CPU_TEMP="N/A"
fi

echo " ${CPU_USAGE}% ${CPU_TEMP}°C"