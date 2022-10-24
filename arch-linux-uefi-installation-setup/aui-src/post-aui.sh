#!/bin/bash

# dependencies - git, curl
LC_APP_VERSION="0.0.1"
LC_APP_NAME="$(basename -- "$0")"
LC_APP_NAME="${LC_APP_NAME:-post-aui.sh}"

# local variables
LC_SYSMAN="$HOME/.sysman"
LC_CONFIG="$HOME/.config"

# npm_apps=(
# "prettier"
# )

# pip_apps=(
# "flake8"
# "black"
# )

paru_apps=(
  # grub stuff 4 dual boot
  "grub-customizer"
  "ntfs-3g"

  # display server and wm
  "picom-jonaburg-git"   # better compositor
  "xorg-xinit"           # to start X display server
  "alacritty"            # terminal
  "firefox"              # browser
  "awesome"              # window manager
  "xorg"                 # display server
  "blugon"               # blue light filter
  #"picom"                # compositor

  # neovim
  "ripgrep"              # for telescope
  "neovim"               # editor
  "xclip"                # to sync with system clipboard
  "vim"                  # update vim
  "vi"                   # update vi
  
  # tools
  "openssh"              # ssh stuff
  "tree"                 # list files indented by depth recursively
  "htop"                 # interactive process manager
  "ncdu"                 # disc usage analyzer
  "man"                  # read man pages of coreutils
  "lsd"                  # better colored ls and performant
  "bat"                  # better colored cat and performant
  "fd"                   # simple and fast find alternative

  # apps
  "mongodb-compass"      # mongodb front end
  "insomnia-bin"         # electron rest client
  "lxappearance"         # set gtk themes
  "bitwarden"            # password manager
  "rustdesk"             # remote desktop
  "lf"                   # terminal file manager

  # programming
  "python3-pip"          # python package manager
  "python"               # python programming language

  # themes
  "nerd-fonts-hack"      # hack font patched nerd font
  "arc-gtk-theme"        # dark gtk apps
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

_test_mv() {
  if test -f "$1"; then mv -fn "$1" "$1-old"; fi
}

_test_mkdir() {
  if [[ ! -d "$1" ]]; then mkdir "$1"; fi
}

_ln_home() {
  local src="${1:-}"
  local dst="${2:-$src}"
  _test_mv "$HOME/$dst"
  ln -s "$LC_SYSMAN/$src" "$HOME/$dst"
  echo "ln -s $LC_SYSMAN/$src $HOME/$dst"
}

_ln_config() {
  local src="${1:-}"
  local dst="${2:-$src}"
  _test_mv "$LC_CONFIG/$dst"
  ln -s "$LC_SYSMAN/$src" "$LC_CONFIG/$dst"
  echo "ln -s $LC_SYSMAN/$src $LC_CONFIG/$dst"
}

sub_check() {
  echo "running checks.."
  # echo "$EUID - 0 is root"
  if [ "$EUID" = "0" ]; then
   echo "ERROR: please do not run this script as root"
   exit 1
  fi

  # check if these progerams are installed
  _check git
  _check curl
  # _check pacman
}

sub_setup() {
  echo "shettup"
  # clone the configs
  # git clone "https://github.com/itzjustalan/.sysman.git"

  # test and create the config dir
  _test_mkdir "$LC_CONFIG"

  # link up moi configs
  _ln_config "alacritty"
  _ln_config "awesome"
  _ln_config "dunst"
  _ln_config "nvim-lua" "nvim"
  _ln_config "paru"
  _ln_config "picom-jonaburg" "picom"
  _ln_home "ssh/config" ".ssh/config"
  _ln_config "tmux"
  _ln_home ".bash_aliases"
  _ln_home ".bash_archpc" ".bash_thispc"
  _ln_home ".bashrc"
  _ln_home ".vimrc"
  _ln_config "starship.toml"

  # add awesome to .xinitrc
  # echo "exec awesome" >> "$HOME/.xinitrc"

  # ssh setup
  # ssh-keygen -t ed25519 -C "itzjustalan@gmail.com"
  # eval "$(ssh-agent -s)"
  # ssh-add "$HOME/.ssh/id_ed25519"
}

sub_rust() {
  curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
  source "$HOME/.cargo/env"
  # rustup completions bash > "$HOME/.local/share/bash-completion/completions/rustup"
}

sub_paru() { # install paru
  # sudo pacman -S --needed base-devel
  git clone "https://aur.archlinux.org/paru.git"
  cd paru || exit 1
  makepkg -si
  paru --gendb
  # edit config
  #  .sysman/paru/paru.conf 
}

# sub_deps() {
#   echo "installing dependencies"
#   echo "pacman -S ${pacman_apps[*]// /|}"
# }

sub_apps() {
  echo "paru -S ${paru_apps[*]// /|}"
  # shellcheck disable=SC2048,SC2086
  paru -S ${paru_apps[*]// /|}

  # starship
  curl -sS https://starship.rs/install.sh | sh
  # volta.sh
  curl https://get.volta.sh | bash
  # pnpm ! bit of a problem with hard links and stuff
  # curl -fsSL https://get.pnpm.io/install.sh | sh -
}

# sub_pip() {
#   echo "pip install -S ${pip_apps[*]// /|}"
# }

# sub_npm() {
#   echo "npm install -g -S ${npm_apps[*]// /|}"
# }

main() {
  sub_check
  sub_setup
  sub_rust
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
          echo "v$LC_APP_VERSION"
            ;;
        *)
            shift
            sub_"$subcommand" "$@"
            if [ $? = 127 ]; then
                echo "ERROR: '$subcommand' is not a known subcommand."
                echo "RUN: '$LC_APP_NAME --help' for a list of known subcommands."
                exit 1
            fi
            ;;
    esac
  fi
}

run "$@"

exit 0

  # ln -s "$LC_SYSMAN/.bash_aliases" "$HOME/.bash_aliases"
  # ln -s "$LC_SYSMAN/.bash_archpc" "$HOME/.bash_thispc"
  # ln -s "$LC_SYSMAN/.bashrc" "$HOME/.bashrc"
  # ln -s "$LC_SYSMAN/.vimrc" "$HOME/.vimrc"
  # ln -s "$LC_SYSMAN/nvim-lua" "$LC_CONFIG/nvim"

# night light
# paru -S blugon
# (blugon&)
# systemctl --user enable blugon.service
#
#
# - end

