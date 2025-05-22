#!/usr/bin/env bash

set -e

# ─── Configuration ─────────────────────────────────────────────────────────────
DEBUG=false
DRY_RUN=false
VERBOSE=false
CLEAN_BACKUPS=false
TARGET_USER="$USER"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUTO_LINK_DIR="$PROJECT_DIR/links"
TOOLS_FILES_DIR="$PROJECT_DIR/tools"
HOOKS_FILES_DIR="$PROJECT_DIR/hooks"
CUSTOM_LINKS_DIR="$PROJECT_DIR/links/custom"
LOG_FILE="$PROJECT_DIR/.sysman-run.log"
BACKUP_LOG="$PROJECT_DIR/.sysman-backups.txt"

# Custom path mapping: "file_or_folder_inside_$CUSTOM_LINKS_DIR destination_absolute_path"
CUSTOM_MAPPINGS=(
  "test.conf /usr/local/share/other/other.conf"
)

echo "=====[ sysman setup: $(date) ]=====" >> "$LOG_FILE"

# ─── Utility Functions ─────────────────────────────────────────────────────────
quiet() {
  if $DEBUG; then
    "$@" 2>&1 | tee -a "$LOG_FILE"
  else
    "$@" > /dev/null 2>> "$LOG_FILE"
  fi
}

log() {
  local msg="[INFO] $1"
  echo "$msg" >> "$LOG_FILE"
  $VERBOSE && echo "$msg"
}

debug_log() {
  echo "[DEBUG] $1" >> "$LOG_FILE"
  $DEBUG && echo "[DEBUG] $1"
}

d_log() {
  debug_log "$1"
}

detect_package_manager() {
  # TODO: install paru via post install if arch
  if command -v paru &>/dev/null; then echo "paru"
  elif command -v pacman &>/dev/null; then echo "pacman"
  elif command -v apt-get &>/dev/null; then echo "apt"
  elif command -v brew &>/dev/null; then echo "brew"
  elif command -v apk &>/dev/null; then echo "apk"
  elif command -v dnf &>/dev/null; then echo "dnf"
  else echo "unknown"
  fi
}

detect_platform() {
  uname_out="$(uname -s)"
  case "${uname_out}" in
    Linux*)
      if grep -qEi "(microsoft|wsl)" /proc/version &>/dev/null; then
        echo "wsl"
      elif [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"  # e.g., ubuntu, arch
      else
        echo "linux"
      fi
      ;;
    Darwin*) echo "macos" ;;
    *) echo "unknown" ;;
  esac
}

install_tools() {
  local pkgmgr=$(detect_package_manager)
  local tools_file="$TOOLS_FILES_DIR/${pkgmgr}"

  [[ "$pkgmgr" == "unknown" ]] && echo "package manager found." && exit 1
  [[ ! -f "$tools_file" ]] && echo "$tools_file not found." && exit 1

  # Read all tools into a single string, ignoring comments and blank lines
  local tools=$(grep -vE '^\s*#|^\s*$' "$tools_file" | xargs)

  if [[ -z "$tools" ]]; then
    log "No tools to install for $pkgmgr"
    return
  fi

  log "Installing tools with $pkgmgr: $tools"

  if $DRY_RUN; then
    log "[dry-run] Would install tools with $pkgmgr: $tools"
    return
  fi

  case "$pkgmgr" in
    apt) quiet sudo apt-get install -y $tools ;;
    dnf) quiet sudo dnf install -y $tools ;;
    pacman) quiet sudo pacman -S --noconfirm $tools ;;
    brew) quiet brew install $tools ;;
    *) echo "Unsupported package manager: $pkgmgr" && exit 1 ;;
  esac
}

should_skip() {
  local skip=(
    '.' '..' '.git' '.DS_Store' 'Thumbs.db' 'desktop.ini'
    'System Volume Information' '$RECYCLE.BIN'
  )
  local name="$(basename "$1")"
  shift
  skip+=("$@")
  for pattern in "${skip[@]}"; do
    [[ "$name" == "$pattern" ]] && return 0
  done
  return 1
}

symlink_file() {
  local src="$1"
  local dest="$2"
  local timestamp
  timestamp=$(date +%Y%m%d%H%M%S)

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    return
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup="${dest}.backup.${timestamp}"
    if $DRY_RUN; then
      log "[dry-run] Would back up: $dest → $backup"
    else
      log "Backing up: $dest → $backup"
      quiet mv "$dest" "$backup"
      echo "$backup" >> "$BACKUP_LOG"
    fi
  fi

  if $DRY_RUN; then
    log "[dry-run] Would symlink: $src → $dest"
  else
    mkdir -p "$(dirname "$dest")"
    quiet ln -sf "$src" "$dest"
    log "Linked: $src → $dest"
  fi
}

symlink_files_for() {
  local prefix="$1"  # can be "" or "hosts/hostname_or_platform"
  local home_dir=$(eval echo "~$TARGET_USER")

  local home_source config_source
  home_source="$AUTO_LINK_DIR/${prefix:+$prefix/}home"
  config_source="$AUTO_LINK_DIR/${prefix:+$prefix/}config"

  if [[ -d "$home_source" ]]; then
    for file in "$home_source"/*; do
      should_skip "$file" && continue
      symlink_file "$file" "$home_dir/$(basename "$file")"
    done
  fi

  if [[ -d "$config_source" ]]; then
    for file in "$config_source"/*; do
      should_skip "$file" && continue
      symlink_file "$file" "$home_dir/.config/$(basename "$file")"
    done
  fi
}

symlink_files_for_custom() {
  log "Linking custom paths..."
  for entry in "${CUSTOM_MAPPINGS[@]}"; do
    local src="$CUSTOM_LINKS_DIR/$(cut -d' ' -f1 <<< "$entry")"
    local dest="$(cut -d' ' -f2- <<< "$entry")"

    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
      return
    fi

    if $DRY_RUN; then
      log "[dry-run] Would symlink: $src → $dest"
    else
      symlink_file "$src" "$dest"
    fi
  done
}

symlink_files() {
  symlink_files_for "shared"
  symlink_files_for "$PLATFORM"
  symlink_files_for "$HOSTNAME"

  symlink_files_for_custom
}

run_pre_hooks() {
  local hooks=(
    "$HOOKS_FILES_DIR/shared/pre.sh"
    "$HOOKS_FILES_DIR/$PLATFORM/pre.sh"
    "$HOOKS_FILES_DIR/$HOSTNAME/pre.sh"
  )

  for hook in "${hooks[@]}"; do
    if [[ -f "$hook" ]]; then
      if $DRY_RUN; then
        log "[dry-run] Would run hook: $hook"
      else
        $VERBOSE && bash "$hook" || quiet bash "$hook"
      fi
    fi
  done
}

run_hooks_for() {
  local prefix="$1"  # can be "" or "hooks/hostname_or_platform"
  local post_hook="$HOOKS_FILES_DIR/${prefix:+$prefix/}/post.sh"

  if [[ -d "$HOOKS_FILES_DIR/${prefix:+$prefix/}" ]]; then
    for file in "$HOOKS_FILES_DIR/${prefix:+$prefix/}"/*; do
      should_skip "$file" "pre.sh" "post.sh" && continue
      if $DRY_RUN; then
        log "[dry-run] Would run hook: $hook"
      else
        $VERBOSE && bash "$file" || quiet bash "$file"
      fi
    done
  fi

  if [[ -f "$post_hook" ]]; then
    if $DRY_RUN; then
      log "[dry-run] Would run hook: $hook"
    else
      $VERBOSE && bash "$post_hook" || quiet bash "$post_hook"
    fi
  fi
}

run_hooks() {
  run_hooks_for "shared"
  run_hooks_for "$PLATFORM"
  run_hooks_for "$HOSTNAME"
}

clean_backups() {
  if [ "$CLEAN_BACKUPS" = false ]; then
    return
  fi

  if [[ ! -s "$BACKUP_LOG" ]]; then
    log "No backups to clean." && return
  fi

  log "Cleaning backups listed in: $BACKUP_LOG"

  while IFS= read -r backup; do
    [[ ! -e "$backup" ]] && continue
    rm -rf "$backup"
  done < "$BACKUP_LOG"

  rm -rf "$BACKUP_LOG"
}

print_usage() {
  cat <<EOF
Usage: $0 [options]

Options:
  --debug                 Show full command output (stdout/stderr)
  --dry-run, -d           Simulate actions without making changes
  --verbose, -v           Show informative log output
  --clean-backups, -c     Clean up backed up files and exit
  --user, -u USERNAME     Setup files for a specific user (e.g. root)
  --help, -h              Show this help message and exit

Examples:
  $0 --verbose
  $0 --dry-run --user root
  $0 --clean-backups
EOF
}

# ─── Argument Parsing ──────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case "$1" in
    --debug) DEBUG=true ;;
    --dry-run|-d) DRY_RUN=true ;;
    --verbose|-v) VERBOSE=true ;;
    --help|-h) print_usage; exit 0 ;;
    --user|-u) shift; TARGET_USER="$1" ;;
    --clean-backups|-c) CLEAN_BACKUPS=true ;;
    *) echo "Unknown option: $1"; print_usage; exit 1 ;;
  esac
  shift
done

if $CLEAN_BACKUPS; then
  clean_backups
  exit 0
fi

# ─── Main ──────────────────────────────────────────────────────────────────────
PLATFORM=$(detect_platform)
HOSTNAME=$(hostname)

log "Platform: $PLATFORM"
log "Hostname: $HOSTNAME"

run_pre_hooks
install_tools
symlink_files
run_hooks

[[ -f "$BACKUP_LOG" ]] && log "Files backed up and not deleted yet -"
[[ -f "$BACKUP_LOG" ]] && cat "$BACKUP_LOG"
[[ -f "$BACKUP_LOG" ]] && log "run: $0 --clean-backups # to delete the backups"

$VERBOSE && echo "Setup complete for user: $TARGET_USER"

