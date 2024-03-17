#!/bin/bash

# run as sudo to install the
# dependencies - git, curl, pacman,
# server as a base temlate to setup new user and install some basic stuff and 
# thats it


AppVersion="0.0.1"
AppName="$(basename -- "$0")"
AppName="${AppName:-awesome-wm-setup}"


LC_ADMIN_USER_NAME='alan'
LC_ADMIN_USER_PASS='password'

pacman_apps=(
"base-devel"
"base"
"curl"
"git"
"vim"
"vi"
)

_check() { # check if a program is installed
  if ! command -v "$1" &> /dev/null; then
      echo "ERROR: $1 not found!"
      echo "RUN: sudo pacman -S $1"
      echo "-- OR --"
      echo "run the post installation script"
      exit 1
  fi
}

sub_check() {
  echo "running checks.."
  # echo "$EUID == 0 is root"
  if [ "$EUID" != "0" ]; then
   echo "ERROR: not root"
   exit 1
  fi

  # check if these progerams are installed
  _check git
  _check pacman
}

sub_user() {
  LC_PASS_STR="$LC_ADMIN_USER_NAME:$LC_ADMIN_USER_PASS"
  useradd -m -G wheel "$LC_ADMIN_USER_NAME"; echo "$LC_PASS_STR" | chpasswd
}

sub_deps() {
  echo "installing dependencies"
  echo "pacman -S ${pacman_apps[*]// /|}"
  pacman -S ${pacman_apps[*]// /|}
}

sub_grub() {
  echo "grub - customiser.."
}

sub_setup() {
  cp -r "/root/aui-src" "/home/$LC_ADMIN_USER_NAME/"
}

main() {
  sub_check
  sub_user
  sub_deps
  sub_grub
  sub_setup

  echo "ran main fn"
}

run() {
  if [ "$#" = 0 ]; then # when ran with no arguments
    # echo "no args provided.. exec default install.."
    main
  else
    local subcommand="$1"
    case "$subcommand" in
        "" | "-h" | "--help")
            sub_help
            ;;
        "-v" | "--version")
          echo "v$AppVersion"
            ;;
        *)
            shift
            sub_"$subcommand" "$@"  > /dev/null 2>&1
            if [ $? = 127 ]; then
                echo "ERROR: '$subcommand' is not a known subcommand."
                echo "RUN: '$AppName --help' for a list of known subcommands."
                exit 1
            fi
            ;;
    esac
  fi
}

run "$@"


