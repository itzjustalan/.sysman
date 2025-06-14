#!/usr/bin/env bash

set -e

if command -v zoxide &>/dev/null; then
  echo "installing zoxide"
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

if command -v fx &>/dev/null; then
  echo "installing fx"
  curl https://fx.wtf/install.sh | sh
fi

