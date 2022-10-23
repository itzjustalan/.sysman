#!/bin/bash

# dependencies - git, curl, pacman,
AppVersion="0.0.1"
AppName="$(basename -- "$0")"
AppName="${AppName:-post-aui.sh}"

npm_apps=(
"prettier"
)

pip_apps=(
"flake8"
"black"
)

pacman_apps=(
"base-devel"
"base"
"curl"
"git"
)

paru_apps=(
"xorg-xinit"
"awesome"
"firefox"
"picom"
"xorg"
"ripgrep"
"fd"
"ly"
"lsd"
"xclip"
"vim"
"vi"
"bitwarden"
"rustdesk"
"tree"
"ntfs-3g"
"lf"
"htop"
"ripgrep"
"fd"
"python"
"python3-pip"
"neovim"
"bat"
"nitrogen"
"nerd-fonts-hack"
"mongodb-compass"
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
  # echo "$EUID - 0 is root"
  if [ "$EUID" = "0" ]; then
   echo "ERROR: please do not run this script as root"
   exit 1
  fi

  # check if these progerams are installed
  # _check git
  # _check pacman
}

sub_paru() { # install paru
  # sudo pacman -S --needed base-devel
  git clone "https://aur.archlinux.org/paru.git"
  cd paru
  makepkg -si
  paru --gendb
  # edit config
  #  .sysman/paru/paru.conf 
}

sub_deps() {
  echo "installing dependencies"
  echo "pacman -S ${pacman_apps[*]// /|}"
}

sub_apps() {
  echo "paru -S ${paru_apps[*]// /|}"
}

sub_pip() {
  echo "pip install -S ${pip_apps[*]// /|}"
}

sub_npm() {
  echo "npm install -g -S ${npm_apps[*]// /|}"
}

main() {
  sub_check
  sub_paru
  sub_apps

  echo "ran main fn"
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

exit 0


# night light
# paru -S blugon
# (blugon&)
# systemctl --user enable blugon.service
#
#
# - end
