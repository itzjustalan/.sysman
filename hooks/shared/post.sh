#!/usr/bin/env bash

# set -e

if ! command -v mise &>/dev/null; then
  log_info "installing mise"
  curl https://mise.run | sh
fi

if ! command -v rustc &>/dev/null; then
  log_info "installing rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -sSf | sh -s -- -y
fi

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

