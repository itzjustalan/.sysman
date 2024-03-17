#!/bin/bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# Battery percentage at which to notify
WARNING_LEVEL=35
BATTERY_NOTIFICATION_ID=9991

run() { 
  BATTERY_DISCHARGING=$(acpi -b | grep "Battery 0" | grep -c "Discharging")
  BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')

  if [ "$BATTERY_DISCHARGING" -eq 1 ]; then
    notify-send "Battery Disconnected" "${BATTERY_LEVEL}% of battery remaining." -u critical -i "battery-alert" -r "$BATTERY_NOTIFICATION_ID"
  fi

  if [ "$BATTERY_LEVEL" -le $WARNING_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ]; then
    notify-send "Low Battery" "${BATTERY_LEVEL}% of battery remaining." -u critical -i "battery-alert" -r "$BATTERY_NOTIFICATION_ID"
  fi


  # else
    # notify-send "Battery Info" "$(acpi -b)" -i "battery" -r "$BATTERY_NOTIFICATION_ID"
  # fi
}

main() { 
  # run "$@";
  while true; do
    run "$@";
    sleep 5s;
  done
}

main "$@"
