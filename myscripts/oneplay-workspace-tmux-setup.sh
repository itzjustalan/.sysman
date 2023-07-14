#!/bin/sh

# run ```tmux kill-server``` if things get weird

G_WP_NAME=oneplay
G_WP_DIR="$HOME/work/oneplay"
G_WPB_DIR="$HOME/work/oneplay/backend"
G_WPF_DIR="$HOME/work/oneplay/frontend"
G_WP_DEP_EXEC="./workspace-deps.sh"

# options
G_SC_BARE=false                  # run only the tmux conf
G_RUN_DEV=false                  # run dev tools

declare -A apps
apps["opw","dir"]="oneplay_web"
apps["acs","dir"]="accountservices"
apps["cas","dir"]="oneplay-career-api"
apps["gms","dir"]="oneplay-games-api"
apps["gts","dir"]="oneplay-gateway-service"
apps["los","dir"]="oneplay-logging-api"
apps["nos","dir"]="oneplay-notifications-api"
apps["sos","dir"]="oneplay-social-api"
apps["sts","dir"]="oneplay-streams-api"
apps["pas","dir"]="partners-service"
apps["opa","dir"]="opratel-partners-api"

for app in "${!apps[@]}"; do # initialise all options to false
  app=$(echo "$app" | cut -d',' -f1)
  apps["$app","run"]="false"
  apps["$app","edit"]="false"
  apps["$app","start"]="false"
done

setupWindow() {
  local dir name
  local "${@}" # set local variables from args
  # local dir name run=false edit=false start=false
  # echo "$@" "$name" "${apps[$name]}" "$start" "${apps[$name,start]}"
  # $start && # echo "started!!"

  cd "${apps[$name,dir]}"
  tmux new-window -n "$name"
  if ${apps[$name,start]}; then
    tmux send-keys './dev.sh' 'Enter'
    # tmux split-window -hZ
    tmux split-window -h
    tmux send-keys 'nv .' 'Enter'
    tmux last-pane -Z
  else
    ${apps[$name,run]} && tmux send-keys './dev.sh' 'Enter'
    # tmux split-window -hZ
    tmux split-window -h
    ${apps[$name,edit]} && tmux send-keys 'nv .' 'Enter'
    tmux last-pane -Z
  fi
  cd "-" 1> /dev/null
}

setupTMUX() {

  cd "$G_WP_DIR"
  tmux new-session -s "$G_WP_NAME" -n dev -d

  cd "$G_WPF_DIR"
  # setupWindow name=opw start=true
  setupWindow name=opw

  cd "$G_WPB_DIR"
  setupWindow name=gts
  setupWindow name=acs
  setupWindow name=cas
  setupWindow name=gms
  setupWindow name=los
  setupWindow name=nos
  setupWindow name=sos
  setupWindow name=sts
  # setupWindow name=pas
  # setupWindow name=opa

  # cd "$G_WPB_DIR"
  # tmux new-window -n "db"

  # cd "$G_WPF_DIR"
  # setupWindow name=acf
  # setupWindow name=axf
  # setupWindow name=asf

  cd "$G_WP_DIR"
  tmux new-window -n "deps"
  tmux send-keys "$G_WP_DEP_EXEC" 'Enter'

  # Select window #1 and attach to the session
  tmux select-window -t "$G_WP_NAME:2"

  # -2 Force tmux to assume the terminal supports 256 colours.
  # This is equivalent to -T 256.
  # tmux -2 attach-session -t "$G_WP_NAME"
  # tmux -2 attach-session
  # tmux attach-session
}



if [ "$#" = 0 ]; then # when ran with no arguments
  # customise this section for the season
  #mongodb-compass &> /dev/null &
  #insomnia &> /dev/null &
  # (insomnia-designer --in-process-gpu &> /dev/null &)
  # (google-chrome-stable &> /dev/null &)
	G_SC_BARE=false
  # apps["opw","start"]="true"
  # apps["acs","start"]="true"
  # apps["los","start"]="true"
  # apps["gts","start"]="true"
  # apps["sos","start"]="true"

else
	# only initialise options
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
      echo "--allizgoood"
      # (mingo &> /dev/null &)
      # mongodb-compass &> /dev/null &
      # (insomnia-designer --in-process-gpu &> /dev/null &)
    elif [ -n "${apps[$flag,dir]}" ]; then
      echo "${apps[$flag,dir]}"
      # apps[$flag,start]=true
    elif [ "$flag" = "-d" ] || [ "$flag" = "--dev" ]; then
      echo "--debb"
      # (mingo &> /dev/null &)
      # mongodb-compass &> /dev/null &
      # (google-chrome-stable &> /dev/null &)
      # (insomnia-designer --in-process-gpu &> /dev/null &)
    fi
  done
fi

setupTMUX
tmux attach-session


# start util pgms
#mongodb-compass &> /dev/null &
#insomnia-designer &> /dev/null &
#/opt/google/chrome/chrome &

