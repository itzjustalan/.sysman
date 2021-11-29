#!/bin/bash

echo "*************************************************"
echo "*                                               *"
echo "*  !! alan's arch linux installation script !!  *"
echo "*                                               *"
echo "*************************************************"
echo ""


# local variables
LC_CONFIRM_ALL=false
LC_KEYBOARD_LAYOUT="us"
LC_TIMEZONE="Asia/Kolkata"


# local functions
setupkeyboard() {
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

#init(){}

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
      echo "$i, ${LC_RCLINES[$i]}"
      echo "${LC_RCLINES[$i]}" >> "$LC_RCFILE"
    done;
    cat $LC_RCFILE
    rm $LC_RCFILE
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
      "syntax on"
      "set nu rnu"
      "set tabstop=2"
      "set belloff=all"
      "set noerrorbells"
      "inoremap jj <esc><esc>"
      ""
      "\" above lines were added by a script"
      ""
    );
    for (( i=0; i<"${#LC_RCLINES[@]}"; i++ )); do
      echo "$i, ${LC_RCLINES[$i]}"
      echo "${LC_RCLINES[$i]}" >> "$LC_RCFILE"
    done;
    cat $LC_RCFILE
    rm $LC_RCFILE
	fi
}

setuptimezone() {
  timedatectl set-timezone "LC_TIMEZONE"
  timedatectl set-ntp true
  hwclock --systohc
  timedatectl status
}

#setupwifi() {}










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
