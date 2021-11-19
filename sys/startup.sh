#!/bin/sh

# spin up the monitors
xrandr --output HDMI-1-1 --auto --rotate right --left-of eDP-1

# run dateFile
#date +%F > ~/dateFile

# set wallpaper
feh --no-fehbg --bg-fill ~/downloads/959294.jpg ~/downloads/4k-nature-wallpapers-ultra-hd-71-1920x1080.jpg
#imgpath="/media/win/f/linux/root/myfiles/repos/wallpapers"
#img=$(ls $imgpath | shuf -n 1)
##wal -ni $imgpath/$img
#wal -i $imgpath/$img
#chwall next &

while true;do chwall next;sleep 5m;done &

# compositor
picom

# blue light filter
blugon -wf &

# dictionary
artha &

# mount drives
#sudo ntfs-3g -o permissions /dev/sda1 /media/win/e
#sudo ntfs-3g -o permissions /dev/sda2 /media/win/f
#sudo ntfs-3g -o permissions /dev/sda3 /media/win/g
#sudo ntfs-3g -o permissions /dev/nvme0n1p4 /media/win/d
#sudo ntfs-3g -o permissions /dev/nvme0n1p3 /media/win/c


# WELCOME
#if [ "$(date +%F)" != "$(cat ~/dateFile)" ];then
if [ "$(date +%F)" == "$(cat ~/dateFile)" ];then
    sleep 8s;
    st -e ~/.local/bin/sys/welcome.sh &
    date +%F > ~/dateFile
fi


echo "all done!"

xsetroot -name "melcow"
syncwiki &
