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

if ! command -v nvim &>/dev/null; then
  log_info "installing neovim";
  if [[ "$PLATFORM" == "macos" ]]; then
      arch_name="$(uname -m)"
      if [ "$arch_name" = "arm64" ]; then
        curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
        tar xzf nvim-macos-arm64.tar.gz
        sudo mv nvim-macos-arm64/bin/nvim /usr/local/bin/nvim
        rm -rf nvim-macos-arm64 nvim-macos-arm64.tar.gz
      else
        curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz
        tar xzf nvim-macos-x86_64.tar.gz
        sudo mv nvim-macos-x86_64/bin/nvim /usr/local/bin/nvim
        rm -rf nvim-macos-x86_64 nvim-macos-x86_64.tar.gz
      fi
  else
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    tar -xzf nvim-linux-x86_64.tar.gz
    sudo mv nvim-linux64/bin/nvim /usr/local/bin/nvim
    rm -rf nvim-linux64 nvim-linux-x86_64.tar.gz
  fi
fi

