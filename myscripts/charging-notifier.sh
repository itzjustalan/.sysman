#!/bin/sh

export XAUTHORITY=/home/alan/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
# Pass 1 as an argument for charging, 0 for discharging
BATTERY_CHARGING=$1
BATTERY_LEVEL=`acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)'`

# Send notifications
if [ $BATTERY_CHARGING -eq 1 ]; then
    notify-send "Charging" "${BATTERY_LEVEL}% of battery charged." -u low -i "battery-charging" -t 5000 -r 9991
elif [ $BATTERY_CHARGING -eq 0 ]; then
    notify-send "Discharging" "${BATTERY_LEVEL}% of battery remaining." -u low -i "battery" -t 5000 -r 9991
fi
