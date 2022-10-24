#!/bin/bash

# configuration variables
LC_BRIGHTNESS='8000'
LC_KEYBOARD_LAYOUT='us'
LC_TIMEZONE='Asia/Kolkata'
LC_WIFI_DEVICE='wlan0'
LC_WIFI_SSID='name'
LC_WIFI_PASS='pass'
LC_INST_PART='/dev/sdaX'
LC_SWAP_PART='/dev/sdaX'
LC_EFI_PART='/dev/nvme0n1p1'
LC_HOST_NAME='hp52tx'
LC_CPU_MICRO_CODE='intel-ucode' # intel-ucode or amd-ucode
LC_ADMIN_USER_NAME='alan'
# LC_ADMIN_USER_PASS='password'
# LC_BOOT_LOADER_ID='GRUB02' # souldn't be an option always user default (GRUB)

LC_PACMAN_APPS=( # apps to be installed with pacman
  "$LC_CPU_MICRO_CODE"
  "networkmanager"
  "base-devel"
  "reflector"
  "base"
  "sudo"
  "curl"
  "man"
  "git"
  "vim"
  "vi"
)

# local variables
LC_APP_VERSION="0.0.1"
LC_APP_NAME="$(basename -- "$0")"
LC_APP_NAME="${LC_APP_NAME:-pre-aui.sh}"

# local functions
countto() {
  LC_COUNT="$1"
  LC_COUNT=${LC_COUNT:=5}
  for (( i=1; i<=LC_COUNT; i++ )); do
    echo -n "$i..";
    sleep 1s;
  done
  echo ""
}

countfrom() {
  LC_COUNT="$1"
  LC_COUNT=${LC_COUNT:=5}
  for (( i=LC_COUNT; i>0; i-- )); do
    echo -n "$i..";
    sleep 1s;
  done
  echo ""
}

# sub commands
sub_init() { # dim brightness
	echo "$LC_BRIGHTNESS" > /sys/class/backlight/intel_backlight/brightness
}

sub_banner() { # print a banner and configurations
  echo ""
  echo "please quit if you haven't reviewed these configurations. ctrl+C to quit"
  echo ""
  echo "TIMEZONE:        $LC_TIMEZONE"
  echo "EFI_PART:        $LC_EFI_PART"
  echo "INST_PART:       $LC_INST_PART"
  echo "SWAP_PART:       $LC_SWAP_PART"
  echo "HOST_NAME:       $LC_HOST_NAME"
  echo "WIFI_SSID:       $LC_WIFI_SSID"
  echo "WIFI_PASS:       $LC_WIFI_PASS"
  echo "WIFI_DEVICE:     $LC_WIFI_DEVICE"
  echo "CPU_MICRO_CODE:  $LC_CPU_MICRO_CODE"
  echo "KEYBOARD_LAYOUT: $LC_KEYBOARD_LAYOUT"
  echo ""
  echo "you can use cfdisk to partition your drives"
  echo "additional tips: lsblk, blkid"
  echo ""
  lsblk
  echo ""
  countfrom 10 # give them time to quit
  echo ""
  echo "*************************************************"
  echo "*                                               *"
  echo "*  !! alan's arch linux installation script !!  *"
  echo "*                                               *"
  echo "*************************************************"
  echo ""
  countto 3 # count to 3 hehe
}

sub_keyb() { # set keyboard layout
    loadkeys "$LC_KEYBOARD_LAYOUT" &&
    echo "keyboard layout was set to $LC_KEYBOARD_LAYOUT"
}

sub_bash() { # create .bashrc
  LC_RCFILE=".bashrc"
  #TODO check if its zshrc..
  #TODO source the rc file
  echo "updating $LC_RCFILE"
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
    echo "${LC_RCLINES[$i]}" >> "$LC_RCFILE"
    #echo "$i, ${LC_RCLINES[$i]}"
  done;
  ln -s "/root/aui-src/$LC_RCFILE" "/root/"
  #rm $LC_RCFILE
  cat "$LC_RCFILE"
  # source "$LC_RCFILE"
}

sub_vim() { # create .vimrc
  LC_RCFILE=".vimrc"
  echo "updating $LC_RCFILE"
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
  ln -s "/root/aui-src/$LC_RCFILE" "/root/"
  cat "$LC_RCFILE"
}

sub_TZ() { # set Time Zone
  timedatectl set-timezone "$LC_TIMEZONE"
  timedatectl set-ntp true
  hwclock --systohc
  timedatectl status
}

sub_wifi() { # connect to wifi
  echo "connecting to $LC_WIFI_SSID"
  iwctl device list > /dev/null 2>&1
  iwctl station "$LC_WIFI_DEVICE" scan > /dev/null 2>&1
  iwctl station "$LC_WIFI_DEVICE" get-networks > /dev/null 2>&1
  iwctl --passphrase "$LC_WIFI_PASS" station "$LC_WIFI_DEVICE" connect "$LC_WIFI_SSID";
  #iwctl station "$LC_WIFI_DEVICE" disconnect
  ping -c 3 archlinux.org
}

sub_part() { # format partition
  echo ""
  lsblk
  echo ""
  echo "efi: $LC_EFI_PART, swap: $LC_SWAP_PART, ext4: $LC_INST_PART"
  echo "!! FORMATTING $LC_INST_PART to  ext4..  ctrl+C to quit"
  countfrom 10
  mkfs.ext4 -F "$LC_INST_PART"
  mkswap "$LC_SWAP_PART"
  swapon "$LC_SWAP_PART"
  mount "$LC_INST_PART" "/mnt"
  echo "mounted $LC_INST_PART to /mnt"
  mkdir -p "/mnt/efi"
  mount "$LC_EFI_PART" "/mnt/efi"
  echo "mounted $LC_EFI_PART to /mnt/efi"
}

sub_fstab() { # generate fstab
  genfstab -U /mnt >> /mnt/etc/fstab
}

sub_kern() { # install linux kernel
  pacstrap /mnt base base-devel linux linux-firmware efibootmgr grub os-prober
}

sub_root() {
  # set system time zone
  arch-chroot /mnt ln -sf "/usr/share/zoneinfo/$LC_TIMEZONE" "/etc/localtime"
  arch-chroot /mnt timedatectl set-timezone "$LC_TIMEZONE"
  arch-chroot /mnt timedatectl set-ntp true
  arch-chroot /mnt hwclock --systohc
  arch-chroot /mnt timedatectl status

  # install required packages using pacman
  # pacman -Sy --noconfirm sudo vi vim git curl networkmanager reflector
  # shellcheck disable=SC2048,SC2086
  arch-chroot /mnt pacman -Sy --noconfirm ${LC_PACMAN_APPS[*]// /|}

  # optimising mirrorlist and enable multilib repository and run an update
  arch-chroot /mnt reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
  arch-chroot /mnt sed -i '/#[multilib]/c\[multilib]' /etc/pacman.conf
  arch-chroot /mnt sed -i '/#Include = /etc/pacman.d/mirrorlist/c\Include = /etc/pacman.d/mirrorlist' /etc/pacman.conf
  arch-chroot /mnt pacman -Syyu --noconfirm

  # ???????????????????????????????????
  # ?? test swappiness ?? to like 10 ??
  # ???????????????????????????????????
  
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

  # arch-chroot /mnt {
  #   echo "127.0.0.1     localhost"
  #   echo "::1           localhost"
  #   echo "127.0.1.1     $LC_HOST_NAME.localdomain    $LC_HOST_NAME"
  # } >> /etc/hosts

  # if you want to create initrd
  # pacstrap does this bt default
  arch-chroot /mnt mkinitcpio -P

  # enable systemd services
  arch-chroot /mnt systemctl enable NetworkManager

  # set up network manager
  arch-chroot nmcli d wifi connect "$LC_WIFI_SSID" password "$LC_WIFI_PASS"

  # install and setup grub
  arch-chroot /mnt sed -i '/#GRUB_DISABLE_OS_PROBER=false/c\GRUB_DISABLE_OS_PROBER=false' /etc/default/grub
  arch-chroot /mnt tail -3 /etc/default/grub #todo: remove this line lol!
  arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/efi/ --bootloader-id=GRUB
  arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
  
  # set root password
  echo ""
  echo "set password for the root user"
  arch-chroot /mnt passwd
  # arch-chroot /mnt echo "root:$LC_ADMIN_USER_PASS" | chpasswd

  # add admin user
  # LC_PASS_STR="$LC_ADMIN_USER_NAME:$LC_ADMIN_USER_PASS"
  arch-chroot /mnt useradd -m -G wheel "$LC_ADMIN_USER_NAME";
  # arch-chroot /mnt echo "$LC_PASS_STR" | chpasswd
}


sub_guide() {
  LC_FSTAB_EXAMPLE_URL='https://gist.githubusercontent.com/itzjustalan/9f03b09f28c448bceba73de05510818c/raw/7024428383fcbd65c4226e0160bdd699e54dde25/fstab'
  curl -s "$LC_FSTAB_EXAMPLE_URL" > "/root/fstabExample"
  cp "/root/.bashrc" "/mnt/root/"
  cp "/root/.vimrc" "/mnt/root/"
  cp -r "/root/aui-src" "/mnt/root/"
  cp "/root/fstabExample" "/mnt/home/$LC_ADMIN_USER_NAME/"
  cp "/root/.bashrc" "/mnt/home/$LC_ADMIN_USER_NAME/"
  cp "/root/.vimrc" "/mnt/home/$LC_ADMIN_USER_NAME/"
  cp -r "/root/aui-src" "/mnt/home/$LC_ADMIN_USER_NAME/"
  echo "reboot and login in as root (password: password) and checkout /root/README.md"
  # test installationGuide.txt && cat $_
  echo "an fstab example file have also been downloaded here"
  echo "todo: ask to reboot"
}

sub_user() {
  echo "user stuff"
}

sub_help() {
  echo ""
  echo "USAGE: $LC_APP_NAME <subcommand?>"
  echo ""
  echo "SUBCOMMANDS:"
  echo ""
  echo "    all        # runs all sub modules (default behaviour)"
  echo ""
  echo "    init       # dim brightness and other configurations"
  echo "    banner     # print a banner and configurations"
  echo "    keyb       # set keyboard layout"
  echo "    bash       # create .bashrc"
  echo "    vim        # create .vimrc"
  echo "    TZ         # set Time Zone"
  echo "    wifi       # connect to wifi"
  echo "    part       # format partition"
  echo "    fstab      # generate fstab"
  echo "    kern       # install linux kernel"
  echo "    root       # chroot and setup root"
  echo "    guide      # setup giudes for root"
  echo "    user       # setup user stuff?"
  echo ""
}

main() {
  # run all submodules
  sub_init   # dim brightness
  sub_banner # print a banner and configurations
  sub_keyb   # set keyboard layout
  sub_bash   # create .bashrc
  sub_vim    # create .vimrc
  sub_TZ     # set Time Zone
  sub_wifi   # connect to wifi
  sub_part   # format partition
  sub_fstab  # generate fstab
  sub_kern   # install linux kernel
  sub_root   # chroot and setup root
  sub_guide  # setup giudes for root
  sub_user   # setup user stuff?
}

sub_all() { # runs main
  main
}

run() {

  if [ "$#" = 0 ]; then # when ran with no arguments
    echo "no args provided.. running default install.." && main
  else
    local subcommand="$1"
    case "$subcommand" in
        "" | "-h" | "--help")
            sub_help
            ;;
        "-v" | "--version")
          echo "v$LC_APP_VERSION"
            ;;
        *)
            shift
            sub_"$subcommand" "$@"
            if [ $? = 127 ]; then
              echo ""
              echo "ERROR: '$subcommand' is not a known subcommand."
              echo "RUN: '$LC_APP_NAME --help' for a list of known subcommands."
              exit 1
            fi
            ;;
    esac
  fi
  echo "ran all modules :main"
}


# start script
run "$@";

# find this script at /run/archiso/bootsmn..
# --%r*yoGhLy98R^naK!%--
## reboot and login to you new Arch linux installation
#reboot
## or just shutdown lol
#shutdown now
#
## THE END

LC_HOST_NAME='hp52tx'
