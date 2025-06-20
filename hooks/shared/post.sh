#!/usr/bin/env bash

# set -e

if ! command -v zoxide &>/dev/null; then
  log_info "installing zoxide"
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

if ! command -v fx &>/dev/null; then
  log_info "installing fx"
  curl https://fx.wtf/install.sh | sh
fi

if ! command -v starship &>/dev/null; then
  log_info "installing starship"
  if [[ "$PLATFORM" == "termux" ]]; then
    # pkg install starship
    pkg install getconf
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir /data/data/com.termux/files/usr/bin
  else
    curl -sS https://starship.rs/install.sh | sh -s -- -y
  fi
fi

