#!/bin/bash

echo "*************************************************"
echo "*                                               *"
echo "*  !! alan's arch linux installation script !!  *"
echo "*                                               *"
echo "*************************************************"
echo ""


# local variables
LC_CONFIRM_ALL=false
LC_KEYBOARD_LAYOUT='us'
LC_TIMEZONE='Asia/Kolkata'
LC_WIFI_DEVICE='wlan0'
LC_WIFI_SSID='KAREETHRA'
LC_WIFI_PASS='poipoi'


# local functions
setupkeyboard() {
	#`1234567890-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>?
  LC_KEYBOARD_LAYOUT_TEST_STR="poi"
  if "$LC_CONFIRM_ALL"; then
    #loadkeys "$LC_KEYBOARD_LAYOUT" &&
    echo "keyboard layout set to $LC_KEYBOARD_LAYOUT"
  else
	  read -p "verify keyboard layout? (Y/n): " confirm
  fi
  if [ "LC_CONFIRM_ALL" ]; then
    echo "skipping keyboard layout test"
  elif [[ "$confirm" == [yY] || "$confirm" == "" ]]; then
    echo "type the following keys"
    echo "$LC_KEYBOARD_LAYOUT_TEST_STR"
    read KEYBOARD_TEST_INPUT
    if [[ "$LC_KEYBOARD_LAYOUT_TEST_STR" == "$KEYBOARD_TEST_INPUT" ]]; then
      echo "kays match"
    else
      echo "keys do not match!"
      exit 1;
    fi
  fi
}

init() {
	echo 8000 > /sys/class/backlight/intel_backlight/brightness
}

bashblings() {
  LC_RCFILE=".bashrc"
  #TODO check if its zshrc..
  #TODO source the rc file
  if "$LC_CONFIRM_ALL"; then
    echo "updating $LC_RCFILE"
  else
	  read -p "update $LC_RCFILE? (Y/n): " confirm
  fi
	if [[ "$LC_CONFIRM_ALL" || "$confirm" == [yY] || "$confirm" == "" ]]; then
    declare -a LC_RCLINES=(
      ""
      ""
      "# following lines were added by a script"
      ""
      "set -o vi"
      "alias ll=\"ls -lah\""
      ""
      "# above lines were added by a script"
      ""
    );
    for (( i=0; i<"${#LC_RCLINES[@]}"; i++ )); do
      #echo "$i, ${LC_RCLINES[$i]}"
      echo "${LC_RCLINES[$i]}" >> "$LC_RCFILE"
    done;
    cat $LC_RCFILE
		#TODO ask to source
    #rm $LC_RCFILE
	fi
}

vimblings() {
  LC_RCFILE=".vimrc"
  if "$LC_CONFIRM_ALL"; then
    echo "updating $LC_RCFILE"
  else
	  read -p "update $LC_RCFILE? (Y/n): " confirm
  fi
	if [[ "$LC_CONFIRM_ALL" || "$confirm" == [yY] || "$confirm" == "" ]]; then
    declare -a LC_RCLINES=(
      ""
      ""
      "\" following lines were added by a script"
      ""
      "syntax on  \" enable syntax"
      "set nu rnu   \" line numbers"
      "set tabstop=2  \" tab is now 2 spaces"
      "set belloff=all  \" kill annoying beeps"
      "set noerrorbells \" vibrator lol"
      "inoremap jj <esc><esc> \"  my leader key"
      ""
      "\" above lines were added by a script"
      ""
    );
    for (( i=0; i<"${#LC_RCLINES[@]}"; i++ )); do
      #echo "$i, ${LC_RCLINES[$i]}"
      echo "${LC_RCLINES[$i]}" >> "$LC_RCFILE"
    done;
    cat $LC_RCFILE
    #rm $LC_RCFILE
	fi
}

setuptimezone() {
  timedatectl set-timezone "$LC_TIMEZONE"
  timedatectl set-ntp true
  hwclock --systohc
  timedatectl status
}

setupwifi() {
	echo "bifi"
  if "$LC_CONFIRM_ALL"; then
    echo "connecting to $LC_WIFI_SSID"
		iwctl device list > /dev/null 2>&1
		iwctl station "$LC_WIFI_DEVICE" scan > /dev/null 2>&1
		iwctl station "$LC_WIFI_DEVICE" get-networks > /dev/null 2>&1
		iwctl --passphrase "$LC_WIFI_PASS" station "$LC_WIFI_DEVICE" connect "$LC_WIFI_SSID";
		#iwctl station "$LC_WIFI_DEVICE" disconnect
		#ping -c 3 archlinux.org
  else
		#TODO ask if they wanna specify manually
	  read -p "connect wifi? (Y/n): " confirm
		if [[ "$confirm" == [yY] || "$confirm" == "" ]]; then
		LC_DEVICE_LIST=$(iwctl device list | tail -n +5)
		LC_CHOICE='1'
		echo "$LC_DEVICE_LIST" | nl;
		read -p "select device (default=1): " LC_CHOICE
		LC_DEVICE=$(echo "$LC_DEVICE_LIST" | sed -n "$LC_CHOICE"p | cut -d' ' -f3)
		echo "$LC_DEVICE"
		iwctl station "$LC_DEVICE" disconnect
		iwctl station "$LC_DEVICE" scan
		LC_NWK_LIST=$(iwctl station "$LC_DEVICE" get-networks | tail -n +5)
		LC_CHOICE='1'
		echo "$LC_NWK_LIST" | nl;
		read -p "select network (default=1): " LC_CHOICE
		LC_NWK=$(echo "$LC_NWK_LIST" | cut -c 5- | sed -n "$LC_CHOICE"p | cut -d' ' -f1)
		echo $LC_NWK
		read -p "enter password: " LC_PHRASE
		iwctl --passphrase "$LC_PHRASE" station "$LC_DEVICE" connect "$LC_NWK";
		ping -c 3 archlinux.org
		fi
  fi
}


printguide() {
  LC_FSTAB_EXAMPLE_URL='https://gist.githubusercontent.com/itzjustalan/9f03b09f28c448bceba73de05510818c/raw/7024428383fcbd65c4226e0160bdd699e54dde25/fstab'
  LC_INSTALLATION_GUIDE_URL='https://gist.githubusercontent.com/itzjustalan/19836dfec8bb5b6bd2d8f2b7b3898c6e/raw/fb50f4755f7bef208d937132b77e8daed496b5b7/installationGuide-arch-efi'
  echo ""
  echo "setup complete!"
  echo "downloading additional resources (2files lol)"
  curl -s "$LC_FSTAB_EXAMPLE_URL" > fstabExample
  curl -s "$LC_INSTALLATION_GUIDE_URL" > installationGuide.txt
  echo "follow the following instructions to complete the installation"
  test installationGuide.txt && cat $_
  echo "an fstab example file have also been downloaded here"
}












main() {
	#read -p "confirm all questions? (y/N): " confirm
	#if [[ "$confirm" == [yY] ]]; then
	# LC_CONFIRM_ALL=true
	#else
	# LC_CONFIRM_ALL=false
	#fi

	# handle arguments
	if [ -z "$1" ]; then
		echo "no args"
	else
		# initialise options
		for arg in "$@"; do
			case "$arg" in
				-y|--yes)
					LC_CONFIRM_ALL=true;
					;;
				-i|--interactive)
					LC_CONFIRM_ALL=false;
					;;
				*)
					echo "$arg not found!"
					exit 1;
			esac
		done
	fi

  # run modules
  #setupkeyboard
  #init
  #bashblings
  #vimblings
  #setuptimezone
  #setupwifi
  printguide;

#	if "$LC_CONFIRM_ALL"; then
#		echo speed-throo
#	else
#		echo "oronu oronu"
#	fi	
}


# start script
main "$@";














exit


# setup bash

# load the us keyboard layout
loadkeys us

# check keyboard layout
echo "type the following to test your keyboard layout"
echo "$LC_KEYBOARD_LAYOUT_TEST_STR"
read KEYBOARD_TEST_INPUT


# set sane defaults

#syntax on
#set nu rnu
#inoremap jj <esc><esc>
#oewlkdco8&3nadofi8w340**^^3 ldsf'p0es9Ae*yoGhLy98R^naK!%p9i()8&Yoq3i


# read input output
#
#read -p "load handy aliases? [Y/n]: " confirm
#
#echo "*-$confirm-*"
#
#if [[ "$confirm" == [yY] || "$confirm" == "" ]]; then
# echo confirmedd
#else
# echo "not confirmed"
#fi




exit


## load keyboard layout
#loadkeys us
#
## set monitor backlight (general path)
#echo 8000 > /sys/class/backlight/intel_backlight/brightness
#
## useful bash aliases
#set -o vi
#alias ll="ls -lah"
#
## vim must haves
#syntax on # enable syntax
#set nu rnu # line numbers
#set tabstop=2 # tab is 2 spaces
#set belloff=all # kill annoying beeps
#set noerrorbells # vibrator lol
#inoremap jj <esc><esc> # my leader key
#
## setup date and time
#timedatectl set-timezone "$LC_TIMEZONE"
#timedatectl set-ntp true
#hwclock --systohc
#timedatectl status
#
#
## connect wifi
#iwctl device list
#iwctl station devicename scan
#iwctl station devicename get-networks
#iwctl --passphrase wifipassword station devicename connect wifiname
#
## partition disks
#cfdisk # way better
#[Delete] to clear partition (format)
#[New] to create new partition
#[Type] to chage filesystem
#Linux filesystem
#Linux Swap
#[Quit] close cfdisk
#
## ext4 and swap partitions
#mkfs.ext4 /dev/sdX
#mkswap /dev/sdX
#swapon /dev/sdX
#
## mount new filesystems
#mount /dev/sdX /mnt
#
## mount efi partition for dual boot
## find efi partition with fdisk -l
#mount /dev/sdX /mnt/efi
#
## install required packages for installation
#pacstram /mnt base linux linux-firmware
#
## generate fstab
#genfstab -U /mnt >> /mnt/etc/fstab
#
## get UUIDS
#blkid
#lsblk -f
#fdisk -l
#
## change root dir to the newly mounted partition
#arch-chroot /mnt
#
## set system time zone
#ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
#
## sync hardware clock
#hwclock --synctohc
#
## install required packages
#pacman -Sy vim git
#
## generate locales
## edit /etc/locale.gen and
## uncomment en_US.UTF-8 UTF-8
## then -
#locale-gen
#
## edit /etc/locale.conf and 
## set locale as LANG=en_US.UTF-8
#
#
## edit /etc/vconsole.conf and 
## set keyboard layout
## as KEYMAP=us
#
## edit /etc/hostname and
## set your hostname
#
## edit /etc/hosts file and
## set the following
#127.0.0.1     localhost
#::1           localhost
#127.0.1.1     hostname.localdomain    hostname
#
#
## set up network manager
#
## if you want to create initrd
## pacstrap does this bt default
#mkinitcpio -P
#
## set root password
#passwd
#
## enable bootloader
#pacman -S grub efibootmgr os-prober
#pacman -S amd-ucode # for amd CPUs
#pacman -S intel-ucode # for intel CPUs
#
#grub-mkconfig -o /boot/grub/grub.cfg
#
## then edit that file with this for each entry
#...
#echo 'Loading initial ramdisk'
#initrd	/boot/cpu_manufacturer-ucode.img /boot/initramfs-linux.img
#...
#
## then for systemd-boot edit /boot/loader/entries/entry.conf
#title   Arch Linux
#linux   /vmlinuz-linux
#initrd  /cpu_manufacturer-ucode.img
#initrd  /initramfs-linux.img
#...
#
#
## reboot and login to you new Arch linux installation
#reboot
## or just shutdown lol
#shutdown now
#
## THE END
