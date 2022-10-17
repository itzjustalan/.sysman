#!/bin/bash

echo "*************************************************"
echo "*                                               *"
echo "*  !! alan's arch linux installation script !!  *"
echo "*                                               *"
echo "*************************************************"
echo ""
echo "you can use cfdisk to partition your drives"
echo "additional tips: lsblk, blkid"
echo ""
echo ""


# local variables
LC_CONFIRM_ALL=false
LC_KEYBOARD_LAYOUT='us'
LC_TIMEZONE='Asia/Kolkata'
LC_WIFI_DEVICE='wlan0'
LC_WIFI_SSID='wifi-name'
LC_WIFI_PASS='wifi-password'
LC_INST_PART='/dev/sda3'
LC_SWAP_PART='/dev/sda4'
LC_EFI_PART='/dev/nvme0n1p1'
LC_HOST_NAME='host-name'
LC_CPU_CODE='intel-ucode' # intel-ucode or amd-ucode



# local functions
setupkeyboard() {
	#`1234567890-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>?
  LC_KEYBOARD_LAYOUT_TEST_STR="poi"
  if "$LC_CONFIRM_ALL"; then
    loadkeys "$LC_KEYBOARD_LAYOUT" &&
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
  # dim brightness
	echo 8000 > /sys/class/backlight/intel_backlight/brightness
}

countto() {
  LC_COUNT="$1"
  LC_COUNT=${LC_COUNT:=5}
  for (( i=1; i<=$LC_COUNT; i++ )); do
    echo -n "$i..";
    sleep 1s;
  done
  echo ""
}

countfrom() {
  LC_COUNT="$1"
  LC_COUNT=${LC_COUNT:=5}
  for (( i=$LC_COUNT; i>0; i-- )); do
    echo -n "$i..";
    sleep 1s;
  done
  echo ""
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
      "EDITOR=vim"
      "alias cdd=\"cd ..\""
      "alias ll=\"ls -lah\""
      "alias shtn=\"sudo shutdown now\""
      "alias basha=\"\$EDITOR ~/.bashrc\""
      "alias bbash=\"source ~/.bashrc\""
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
		ping -c 3 archlinux.org
  else
		#TODO ask if they wanna specify manually
	  read -p "connect wifi? (Y/n): " confirm
		if [[ "$confirm" == [yY] || "$confirm" == "" ]]; then
		LC_DEVICE_LIST=$(iwctl device list | tail -n +5)
		LC_CHOICE='1'
		echo "$LC_DEVICE_LIST" | nl;
		read -p "select device (default=$LC_CHOICE): " LC_CHOICE
		LC_DEVICE=$(echo "$LC_DEVICE_LIST" | sed -n "$LC_CHOICE"p | cut -d' ' -f3)
		echo "$LC_DEVICE"
		iwctl station "$LC_DEVICE" disconnect
		iwctl station "$LC_DEVICE" scan
		LC_NWK_LIST=$(iwctl station "$LC_DEVICE" get-networks | tail -n +5)
		LC_CHOICE='1'
		echo "$LC_NWK_LIST" | nl;
		read -p "select network (default=$LC_CHOICE): " LC_CHOICE
		LC_NWK=$(echo "$LC_NWK_LIST" | cut -c 5- | sed -n "$LC_CHOICE"p | cut -d' ' -f1)
		echo $LC_NWK
		read -p "enter password: " LC_PHRASE
		iwctl --passphrase "$LC_PHRASE" station "$LC_DEVICE" connect "$LC_NWK";
		ping -c 3 archlinux.org
		fi
  fi
}

setparts() {
	echo "setparts"
  if "$LC_CONFIRM_ALL"; then
    echo "efi: $LC_EFI_PART, swap: $LC_SWAP_PART, ext4: $LC_INST_PART"
  else
		LC_CHOICE='3'
		blkid | nl;
		read -p "select the partition to install (default=$LC_CHOICE): " LC_CHOICE
    LC_INST_PART=$(blkid | sed "${LC_CHOICE}q;d" | cut -d':' -f1)
    echo $LC_CHOICE $LC_INST_PART
    echo "efi: $LC_EFI_PART, swap: $LC_SWAP_PART, ext4: $LC_INST_PART"
    read -p "format $LC_INST_PART? (y/N): " confirm
	  if [[ "$confirm" != [yY] ]]; then
      return
    fi
  fi

  LC_EFI_PART=$(fdisk -l | grep "EFI System" | cut -d' ' -f1)
  echo "efi: $LC_EFI_PART, swap: $LC_SWAP_PART, ext4: $LC_INST_PART"
  echo "!! FORMATTING $LC_INST_PART to  ext4..  ctrl+C to quit"
  countfrom 5
  mkfs.ext4 -F "$LC_INST_PART"
  mkswap "$LC_SWAP_PART"
  swapon "$LC_SWAP_PART"
  echo "mounting $LC_INST_PART to /mnt"
  mount "$LC_INST_PART" "/mnt"
  echo "mounting $LC_EFI_PART to /mnt/efi"
  mkdir -p "/mnt/efi"
  mount "$LC_EFI_PART" "/mnt/efi"
}

setupfstab() {
  # generate fstab
  genfstab -U /mnt >> /mnt/etc/fstab
  echo "fstab generated check the guide for configuration"
}

setkernel() {
  pacstrap /mnt base base-devel linux linux-firmware efibootmgr grub os-prober
}

chrootmoiboi() {
  echo "chrooting into /mnt.."
  # change root dir to the newly mounted partition
  #arch-chroot /mnt 

  # set system time zone
  arch-chroot /mnt ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

  # sync hardware clock
  arch-chroot /mnt hwclock --systohc

  # install required packages
  arch-chroot /mnt pacman -Sy --noconfirm sudo vi vim git curl networkmanager reflector

  # optimising mirrorlist and enable multilib repository
  arch-chroot /mnt reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
  arch-chroot /mnt sed -i '/#[multilib]/c\[multilib]' /etc/pacman.conf
  arch-chroot /mnt sed -i '/#Include = /etc/pacman.d/mirrorlist/c\Include = /etc/pacman.d/mirrorlist' /etc/pacman.conf
  arch-chroot /mnt pacman -Syyu

  # test swappiness ?? to like 10?
  
  # generate locales
  # edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8
  arch-chroot /mnt sed -i '/#en_US.UTF-8 UTF-8/c\en_US.UTF-8 UTF-8' /etc/locale.gen
  # arch-chroot /mnt sed -i '/#en_IN.UTF-8/c\en_IN.UTF-8' /etc/locale.gen
  arch-chroot /mnt locale-gen

  # edit /etc/locale.conf and 
  # set locale as LANG=en_US.UTF-8
  arch-chroot /mnt echo "LANG=en_US.UTF-8" > /etc/locale.conf


  # edit /etc/vconsole.conf and 
  # set keyboard layout as KEYMAP=us
  arch-chroot /mnt echo "KEYMAP=us" > /etc/vconsole.conf

  # set your hostname in /etc/hostname
  arch-chroot /mnt echo "$LC_HOST_NAME" > /etc/hostname

  # configure /etc/hosts file
  arch-chroot /mnt echo "127.0.0.1     localhost" >> /etc/hosts
  arch-chroot /mnt echo "::1           localhost" >> /etc/hosts
  arch-chroot /mnt echo "127.0.1.1     $LC_HOST_NAME.localdomain    $LC_HOST_NAME" >> /etc/hosts

  # set up network manager

  # if you want to create initrd
  # pacstrap does this bt default
  arch-chroot /mnt mkinitcpio -P

  # enable systemd services
  arch-chroot /mnt systemctl enable NetworkManager


  # enable bootloader
  # echo -e "\t1 pacman -S intel-ucode # for intel CPUs"
  # echo -e "\t2 pacman -S amd-ucode # for amd CPUs"
  # read -p "select cpu microcode to install (default=1): " confirm
	# if [[ "$confirm" == "1" || "$confirm" == "" ]]; then
  #   echo -e "\t1 pacman -S intel-ucode # for intel CPUs"
  # elif [[ "$confirm" == "2" ]]; then
  #   echo -e "\t2 pacman -S amd-ucode # for amd CPUs"
  # else
  #   echo "invalid option ya moron! exiting.."
  # fi

  arch-chroot /mnt sed -i '/#GRUB_DISABLE_OS_PROBER=false/c\GRUB_DISABLE_OS_PROBER=false' /etc/default/grub
  arch-chroot /mnt tail -3 /etc/default/grub #todo: remove this line lol!
  arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/efi/ --bootloader-id=GRUB
  arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
  

  # set root password
  echo "set password for the root user"
  arch-chroot /mnt passwd
  # arch-chroot /mnt useradd -m -G wheel "alan"
  # echo "set password for the new user (alan)"
  # echo "add wheel group to sudo if you want/ZZ"
  # EDITOR=vim arch-chroot /mnt EDITOR=vim visudo


}
  # echo "# now edit /boot/grub/grub.cfg for each entry
# ...
# echo 'Loading initial ramdisk'
# initrd	/boot/cpu_manufacturer-ucode.img /boot/initramfs-linux.img
# ...

# # then for systemd-boot edit /boot/loader/entries/entry.conf
# title   Arch Linux
# linux   /vmlinuz-linux
# initrd  /cpu_manufacturer-ucode.img
# initrd  /initramfs-linux.img
# ..."
# }


printguide() {
  LC_RCFILE="README.md"
  declare -a LC_RCLINES=(
    "#Welcome to Arch Linux!"
    "set root user password by running: passwd root"
    "install cpu microcode via pacman -S intel-ucode/amd-ucode"
    "create new user by: useradd -G wheel -m username && visudo"
    ""
    "#install awesome ? xorg? etc?......???"
    "#sudo pacman -S xorg xorg-xinit awesome firefox"
    "#sudo pacman -S picom nitrogen lxappearance"
    "#echo \"exec awesome\" > ~/.xinitrc"
  );
  LC_FSTAB_EXAMPLE_URL='https://gist.githubusercontent.com/itzjustalan/9f03b09f28c448bceba73de05510818c/raw/7024428383fcbd65c4226e0160bdd699e54dde25/fstab'
  # LC_INSTALLATION_GUIDE_URL='https://gist.githubusercontent.com/itzjustalan/19836dfec8bb5b6bd2d8f2b7b3898c6e/raw/fb50f4755f7bef208d937132b77e8daed496b5b7/installationGuide-arch-efi'
  echo ""
  echo "setup complete!"
  echo "downloading additional resources (2files lol)"
  curl -s "$LC_FSTAB_EXAMPLE_URL" > fstabExample
  # curl -s "$LC_INSTALLATION_GUIDE_URL" > installationGuide.txt
  for (( i=0; i<"${#LC_RCLINES[@]}"; i++ )); do
    echo "${LC_RCLINES[$i]}" >> "$LC_RCFILE"
  done;
  cp fstabExample /mnt/root/
  cp "$LC_RCFILE" /mnt/root/
  cp ".bashrc" /mnt/root/
  cp ".vimrc" /mnt/root/
  #todo: copy the post installation guide and gui installation guide
  echo "reboot and login in as root (no password) and checkout /root/README.md"
  # echo "follow the following instructions to complete the installation"
  # test installationGuide.txt && cat $_
  echo "an fstab example file have also been downloaded here"
  echo "todo: ask to reboot"
}

postinstallationguide() {
  LC_RCFILE="install-awesome-wm.sh"
  declare -a LC_RCLINES=(
    "#!/bin/bash"
    ""
    "passwd root"
    "pacman -S intel-ucode"
    "useradd -G wheel -m alan && visudo"
    "pacman -S --noconfirm xorg xorg-xinit awesome firefox"
    "pacman -S --noconfirm picom nitrogen lxappearance"
    "#echo \"exec awesome\" > ~/.xinitrc"
  );
  for (( i=0; i<"${#LC_RCLINES[@]}"; i++ )); do
    echo "${LC_RCLINES[$i]}" >> "$LC_RCFILE"
  done;
  cp "$LC_RCFILE" /mnt/root/
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

if "$LC_CONFIRM_ALL"; then
	echo "speed-throo"
else
	echo "oronu oronu"
fi

  # run modules
  countto 3
  setupkeyboard
  init # yeesh!!
  bashblings
  vimblings
  setuptimezone
  setupwifi
  setparts
  setkernel
  setupfstab
  chrootmoiboi
  printguide
  postinstallationguide

  echo "ran all modules :main"

#	if "$LC_CONFIRM_ALL"; then
#		echo speed-throo
#	else
#		echo "oronu oronu"
#	fi	
}


# start script
main "$@";

# find this script at /run/archiso/bootsmn..
# --%r*yoGhLy98R^naK!%--
## reboot and login to you new Arch linux installation
#reboot
## or just shutdown lol
#shutdown now
#
## THE END

