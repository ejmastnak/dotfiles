#!/bin/sh
# An awk script to monitor battery capacity and send a desktop notification
# when the battery capacity decreases below a threshold value.
# Original: https://wiki.archlinux.org/title/Laptop#Hibernate_on_low_battery_level

threshold_min=20
threshold_max=95
acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
	read -r status capacity
	if [ "${status}" = Discharging -a "${capacity}" -lt ${threshold_min} ];
  then
    notify-send -t 300000 "Charge your battery!"
	elif [ "${status}" = Charging -a "${capacity}" -gt ${threshold_max} ];
  then
    notify-send -t 300000 "Stop charging your battery!"
	fi
}
