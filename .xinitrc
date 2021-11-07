#exec dwm & wmpid=$!
#
#sleep 0.1
##[[ -f ~/.bashrc ]] && . ~/.bashrc
#~/.system/startup/.startup.sh
#
#wait $wmpid
#startdwm &
#
#
#android studio
export _JAVA_AWT_WM_NONREPARENTING=1

# gnome keyring (vscode)
/etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(gpg-agent --daemon)
#eval $(gnome-keyring-daemon --start)
#export SSH_AUTH_SOCK

dwmspinup &
statusbar.sh &
exec sxhkd &
sleep 0.1
startup.sh
#~/.system/startup/.startup.sh
