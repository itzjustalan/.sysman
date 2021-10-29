# set random wallpaper and pywal
imgpath="/media/win/f/linux/root/myfiles/repos/wallpapers"
img=$(ls $imgpath | shuf -n 1)
#wal -ni $imgpath/$img
wal -i $imgpath/$img

# welcome message
echo "Welcome! have a nice day"
curl wttr.in

# calcurse agenda
calcurse -a


# read user input to stay woke lol
read -p ": "
