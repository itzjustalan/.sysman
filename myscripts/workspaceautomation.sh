#!/bin/sh

# var for session name (to avoid repeated occurences)
LC_WP_NAME=almas-backend
LC_WP_DIR=~/work/backend

# Start the session and window 0 in /etc
#   This will also be the default cwd for new windows created
#   via a binding unless overridden with default-path.
cd "$LC_WP_DIR"
tmux new-session -s "$LC_WP_NAME" -n backend -d

cd app-admin-api
tmux new-window -n "aap"
cd "$LC_WP_DIR"

cd app-admin-ui
tmux new-window -n "aau"
cd "$LC_WP_DIR"

cd app-customer-api
tmux new-window -n "acp"
cd "$LC_WP_DIR"

cd app-sales-executive-api
tmux new-window -n "asx"
cd "$LC_WP_DIR"

cd app-salesman-api
tmux new-window -n "asp"
cd "$LC_WP_DIR"


# Select window #1 and attach to the session
tmux select-window -t "$LC_WP_NAME:1"

# -2 Force tmux to assume the terminal supports 256 colours.
# This is equivalent to -T 256.
#tmux -2 attach-session -t "$LC_WP_NAME"
tmux -2 attach-session
