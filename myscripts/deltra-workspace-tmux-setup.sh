#!/bin/sh

# run ```tmux kill-server``` if things go weird

G_WP_NAME=almas-backend
G_WPB_DIR=~/work/backend
G_WPF_DIR=~/work/almas

# options
G_SC_BARE=false                  # run only the tmux conf

declare -A apps
apps["aap","dir"]="app-admin-api"
apps["aau","dir"]="app-admin-ui"
apps["acp","dir"]="app-customer-api"
apps["axp","dir"]="app-sales-executive-api"
apps["asp","dir"]="app-salesman-api"
apps["acf","dir"]="customer_app2"
apps["axf","dir"]="sales_app2"
apps["asf","dir"]="delivery_app2"

apps["aap","start"]="false"
apps["aau","start"]="false"
apps["acp","start"]="false"
apps["axp","start"]="false"
apps["asp","start"]="false"
apps["acf","start"]="false"
apps["axf","start"]="false"
apps["asf","start"]="false"

# start editors
#code app-admin-api &
#code app-admin-ui &
#code app-customer-api &
#code app-sales-executive-api &
#code app-salesman-api &

# start util pgms
#mongodb-compass &
#insomnia-designer &
#mongodb-compass &> /dev/null &
#insomnia-designer &> /dev/null &
#/opt/google/chrome/chrome &

## actual program ..(workflow)

setupWindow() {
  local dir name start=false
  local "${@}"
  echo "$name" "${apps[$name]}" "$start" "${apps[$name,start]}"
  # $start && echo "started!!"

  pwd
  cd "${apps[$name,dir]}"
  pwd
  tmux new-window -n "$name"
  if $start; then
    tmux send-keys 'nrd' 'Enter'
    tmux split-window -hZ
    tmux send-keys 'nv .' 'Enter'
  else
    ${apps[$name,start]} && tmux send-keys 'nrd' 'Enter'
    ${apps[$name,start]} && tmux split-window -hZ
    ${apps[$name,start]} && tmux send-keys 'nv .' 'Enter'
  fi
  cd "-"
  pwd
}

setupTMUX() {

  cd "$G_WPB_DIR"
  tmux new-session -s "$G_WP_NAME" -n dev -d

  cd "$G_WPB_DIR"
  setupWindow name=aap start=true
  setupWindow name=aau start=true
  setupWindow name=acp start=false
  setupWindow name=axp start=false
  setupWindow name=asp start=false

  cd "$G_WPB_DIR"
  tmux new-window -n "db"

  cd "$G_WPF_DIR"
  setupWindow name=acf start=false
  setupWindow name=axf start=false
  setupWindow name=asf start=false

  cd "$G_WPB_DIR"

  # Select window #1 and attach to the session
  tmux select-window -t "$G_WP_NAME:1"

  # -2 Force tmux to assume the terminal supports 256 colours.
  # This is equivalent to -T 256.
  #tmux -2 attach-session -t "$G_WP_NAME"
  tmux -2 attach-session
  # tmux attach-session
}



if [ "$#" = 0 ]; then
  echo no args
	G_SC_BARE=false
  setupTMUX
  # setupWindow name=aap start=true
  #mongodb-compass &> /dev/null &
  #insomnia-designer &> /dev/null &
  # customise this section for the season
else
	# initialise options
	for arg in "$@"; do
		case "$arg" in
			-b|--bare)
				G_SC_BARE=true
				;;
		esac
	done

  # handel flags
  for flag in "$@"; do
    if [ "$flag" = "-a" ] || [ "$flag" = "--all" ]; then
      echo all
      mongodb-compass &> /dev/null &
      insomnia-designer &> /dev/null &
    elif [ -n "${apps[$flag,dir]}" ]; then
      echo "${apps[$flag,dir]}"
      apps[$flag,start]=true
    elif [ "$flag" = "-d" ] || [ "$flag" = "--dev" ]; then
      mongodb-compass &> /dev/null &
      insomnia-designer &> /dev/null &
    fi
  done

  setupTMUX

fi
