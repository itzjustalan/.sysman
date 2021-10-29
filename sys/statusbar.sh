#!/bin/sh


# emojis --
# 🟥🔴 🛑 🔋 ❗ ‼️

# notification-server
dunst &

while true;do
        updateVolume;
        sleep 5s
done &

while true;do
        updateTime;
        sleep 1s
done &

while true;do
        updateNetwork;
        sleep 1s
done &

while true;do
        updateMemory;
        sleep 2s
done &

while true;do
        updateBattery;
        sleep 5m
done &

while true;do
# read blocks & update bar
        volumeBlock=$(cat /home/alanj/.local/bin/sys/statusblocks/volumeBlock)
        memoryBlock=$(cat /home/alanj/.local/bin/sys/statusblocks/memoryBlock)
        dateBlock=$(cat /home/alanj/.local/bin/sys/statusblocks/dateBlock)
        networkBlock=$(cat /home/alanj/.local/bin/sys/statusblocks/networkBlock)
        batteryBlock=$(cat /home/alanj/.local/bin/sys/statusblocks/batteryBlock)
        notificationBlock=""
        if ps -C cmus > /dev/null; then
            #ARTIST=$(cmus-remote -Q | grep -a '^tag artist' | awk '{gsub("tag artist ", "");print}')
            TRACK=$(cmus-remote -Q | grep -a '^tag title' | awk '{gsub("tag title ", "");print}')
            #notificationBlock="$TRACK"
            notificationBlock="$notificationBlock 📻"
        fi
        xsetroot -name "$notificationBlock $volumeBlock | $memoryBlock | $dateBlock | $networkBlock $batteryBlock"
        sleep 1s
done &








#while true;
#do
#        batStatus=$(cat /sys/class/power_supply/BAT1/status)
#        if [ "$batStatus" = "Discharging" ];
#        then
#                xsetroot -name "!!!!!!!!!!!!!"
#        else
#                xsetroot -name "%%ok"
#        fi
#        sleep 1m
#done &
#
