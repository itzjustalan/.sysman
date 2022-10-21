#!/bin/bash

LC_PROJ_DIR="$HOME/work/deltra"

cd_backend_dir() {
  cd "$LC_PROJ_DIR/backend"
}

clone_repositories() {
  git clone git@github.work:Deltrasofts/app-admin-api.git
  git clone git@github.work:Deltrasofts/app-admin-ui.git
  git clone git@github.work:Deltrasofts/app-customer-api.git
  git clone git@github.work:Deltrasofts/app-sales-executive-api.git
  git clone git@github.work:Deltrasofts/app-salesman-api.git
  # git clone git@github.work:Deltrasofts/app-backend-api.git
}

pin_and_pull() {
  local LC_NODE_VERS="${1:-lts}"
  # pwd && node --version
  # echo "node@$LC_NODE_VERS"
  git switch production
  git switch staging
  git switch main
  git switch dev
  volta pin "node@$LC_NODE_VERS"
  npm install
}

main() {

  # check if volta is installed
  if ! command -v "volta" &> /dev/null; then
      echo "ERROR: volta not found!"
      echo "RUN: curl https://get.volta.sh | bash"
      exit 1
  fi

  # create proj dir if it doesn't exist
  if [[ ! -d "$LC_PROJ_DIR" ]]; then
    mkdir -p "$LC_PROJ_DIR"
    mkdir -p "$LC_PROJ_DIR/flutter"
    mkdir -p "$LC_PROJ_DIR/backend"
  fi

  # backend setup
  cd "$LC_PROJ_DIR/backend"
  # echo "cloning backend repositories in $(pwd)"
  clone_repositories


  cd "app-admin-api"
  pin_and_pull "lts"
  cd_backend_dir

  cd "app-admin-ui"
  pin_and_pull "14"
  cd_backend_dir

  cd "app-customer-api"
  pin_and_pull "lts"
  cd_backend_dir

  cd "app-sales-executive-api"
  pin_and_pull "lts"
  cd_backend_dir

  cd "app-salesman-api"
  pin_and_pull "lts"
  cd_backend_dir

  # cd "app-backend-api"
  # pin_and_pull "lts"
  # cd_backend_dir
}


main "$@"
