#!/usr/bin/env bash

_original_shopt_dotglob=$(shopt -p dotglob 2>/dev/null || echo '')
_original_shopt_nullglob=$(shopt -p nullglob 2>/dev/null || echo '')

restore_shopt_states() {
  if [[ -n "$_original_shopt_dotglob" ]]; then
    eval "$_original_shopt_dotglob"
  fi
  if [[ -n "$_original_shopt_nullglob" ]]; then
    eval "$_original_shopt_nullglob"
  fi
  exit 0
}
# trap 'restore_shopt_states' EXIT ERR SIGTERM SIGINT
trap 'restore_shopt_states' EXIT

shopt -s dotglob
shopt -s nullglob

# ─── Configuration ─────────────────────────────────────────────────────────────
DEBUG=false
SILENT=false
P_EMOJI=true
DRY_RUN=false
CLEAN_BACKUPS=false
TARGET_USER="$(whoami)"
APP_NAME="sysman"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUTO_LINK_DIR="$PROJECT_DIR/links"
HOOKS_FILES_DIR="$PROJECT_DIR/hooks"
TOOLS_FILES_DIR="$PROJECT_DIR/tools"
CUSTOM_LINKS_DIR="$PROJECT_DIR/links/custom"
LOG_FILE="$PROJECT_DIR/.${APP_NAME}-run.log"
BACKUP_LOG="$PROJECT_DIR/.${APP_NAME}-backups.txt"

# Custom path mapping: "file_or_folder_inside_$CUSTOM_LINKS_DIR destination_absolute_path"
CUSTOM_MAPPINGS=(
  # "test.conf /usr/local/share/other/other.conf"
)

OS_PKG_MANAGERS=(
  paru
  pacman
  apt-get
  brew
  apk
  dnf
)

PKG_MANAGERS=(
  cargo
  uv
)

# ─── Imports ─────────────────────────────────────────────────────────────
FILE_IMPORTS=(
  "./paint"
)

for file in "${FILE_IMPORTS[@]}"; do
  if [[ -f "$file" ]]; then
    source "$file"
  else
    echo "$file not found"
    exit 1
  fi
done

LOG_LEVEL_NONE=0
LOG_LEVEL_ERROR=1
LOG_LEVEL_WARN=2
LOG_LEVEL_INFO=3
LOG_LEVEL_DEBUG=4
LOG_LEVEL=${LOG_LEVEL_INFO}

print_emoji() {
  $P_EMOJI && echo "$*"
  return 0
}

log_error() {
  [[ $LOG_LEVEL -ge $LOG_LEVEL_ERROR ]] && echo -e "$(print_emoji '🚨 ')[ $(date +%H:%M:%S) ]$(paint --fg red [ ERR ] $*)"
  return 0
}

log_warn() {
  [[ $LOG_LEVEL -ge $LOG_LEVEL_WARN ]] && echo -e "$(print_emoji ⚠️) [ $(date +%H:%M:%S) ]$(paint --fg yellow [ WRN ] $*)"
  return 0
}

log_info() {
  [[ $LOG_LEVEL -ge $LOG_LEVEL_INFO ]] && echo -e "$(print_emoji ℹ️) [ $(date +%H:%M:%S) ]$(paint --fg blue [ INF ] $*)"
  return 0
}

log_debug() {
  [[ $LOG_LEVEL -ge $LOG_LEVEL_DEBUG ]] && echo -e "$(print_emoji 🤖) [ $(date +%H:%M:%S) ]$(paint --fg grey [ DBG ] $*)"
  return 0
}

log_success() {
  [[ $LOG_LEVEL -ge $LOG_LEVEL_INFO ]] && echo -e "$(print_emoji ✅) [ $(date +%H:%M:%S) ]$(paint --fg green [ SUC ] $*)"
  return 0
}

log_dry() {
  [[ "$DRY_RUN" == "true" ]] && [[ $LOG_LEVEL -ge $LOG_LEVEL_WARN ]] && echo -e "⚠️ [ $(date +%H:%M:%S) ]$(paint --fg yellow [ WRN ]) $(paint --fg purple [ DRY ]) $(paint --fg purple --italic $*)"
  return 0
}

log_time() {
  local start_time=$(date +%s)
  log_info "Started command [$*]"

  eval "$@"
  local exit_code=$?

  local end_time=$(date +%s)
  local duration=$((end_time - start_time))

  local hours=$((duration / 3600))
  local minutes=$(((duration % 3600) / 60))
  local seconds=$((duration % 60))
  local human_duration=$(printf "%02d:%02d:%02d" "$hours" "$minutes" "$seconds")

  if [ $exit_code -eq 0 ]; then
    log_info "Finished command [$*] [Duration: $human_duration]"
  else
    log_error "Command [$*] failed with exit code $exit_code after $human_duration"
  fi

  return $exit_code
}

echo "" >>"$LOG_FILE"
echo "=====[ sysman setup: $(date) ]=====" >>"$LOG_FILE"

# ─── Utility Functions ─────────────────────────────────────────────────────────
quiet() {
  if $SILENT; then
    "$@" >/dev/null 2>>"$LOG_FILE"
  else
    "$@" 2>&1 | tee -a "$LOG_FILE"
  fi
}

detect_os_package_manager() {
  # TODO: install paru via pre install if arch
  for pkgmgr in "${OS_PKG_MANAGERS[@]}"; do
    if command -v "$pkgmgr" &>/dev/null; then
      echo "$pkgmgr"
      return;
    fi
  done
  echo "unknown"
}

detect_platform() {
  uname_out="$(uname -s)"
  case "${uname_out}" in
  Linux*)
    if grep -qEi "(microsoft|wsl)" /proc/version &>/dev/null; then
      echo "wsl"
    elif [ -f /etc/os-release ]; then
      . /etc/os-release
      echo "$ID" # e.g., ubuntu, arch
    elif [ -n "$TERMUX_VERSION" ]; then
      echo "termux"
    else
      echo "linux"
    fi
    ;;
  Darwin*) echo "macos" ;;
  *) echo "unknown" ;;
  esac
}

dos_to_unix() {
  local src="$1"
  local tmpfile

  if [[ ! -f "$src" ]]; then
    log_error "File not found: $src"
    return 1
  fi

  tmpfile=$(mktemp)

  if command -v gsed &>/dev/null; then
    quiet gsed -i 's/^M//g' "$src" >"$tmpfile"
    quiet gsed -i 's/\r$//g' "$src" >"$tmpfile"
  else
    quiet tr -d '\r' <"$src" >"$tmpfile"
  fi

  # Output the cleaned content to stdout
  cat "$tmpfile"
  quiet rm -f "$tmpfile" # Clean up the temporary file
}

install_pakgs() {
  for pkgmgr in "${PKG_MANAGERS[@]}"; do
    if command -v "$pkgmgr" &>/dev/null; then
      local tools_file="$TOOLS_FILES_DIR/${pkgmgr}"
      mapfile -t tools < <(dos_to_unix "$tools_file" | grep -vE '^\s*#|^\s*$')
      case "$pkgmgr" in
      cargo) quiet cargo install "${tools[@]}" ;;
      uv)
        for tool in "${tools[@]}"; do
          quiet uv tool install "$tool"
        done
        ;;
      *) echo "Unsupported package manager: $pkgmgr" && exit 1 ;;
      esac
    fi
  done
}

install_tools() {
  local pkgmgr=$(detect_os_package_manager)
  local tools_file="$TOOLS_FILES_DIR/${pkgmgr}"

  [[ "$pkgmgr" == "unknown" ]] && log_error "package manager found." && return 1
  [[ ! -f "$tools_file" ]] && log_error "$tools_file not found." && return 1

  # Read all tools into a single string, ignoring comments and blank lines
  local tools=$(dos_to_unix "$tools_file" | grep -vE '^\s*#|^\s*$' | xargs)

  if [[ -z "$tools" ]]; then
    log_info "No tools to install for $pkgmgr"
    return
  fi

  log_dry "Would install tools with $pkgmgr: $tools"
  $DRY_RUN && return 0

  log_info "Installing tools with $pkgmgr: $tools"

  case "$pkgmgr" in
  apt-get) quiet sudo bash -c "apt-get update && apt-get install -y --no-install-recommends $tools" ;;
  dnf) quiet sudo bash -c "dnf install -y $tools" ;;
  pacman) quiet sudo bash -c "pacman -S --noconfirm $tools" ;;
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

  local canonical_src
  local canonical_dest_target

  canonical_src=$(cd "$(dirname "$src")" && pwd -P)/$(basename "$src")

  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ -L "$dest" ]]; then
      canonical_dest_target=$(readlink -f "$dest")
    else
      canonical_dest_target=$(cd "$(dirname "$dest")" && pwd -P)/$(basename "$dest")
    fi

    if [[ "$canonical_dest_target" == "$canonical_src" ]]; then
      log_info "Already linked: $src → $dest"
      return
    fi

    local backup="${dest}.backup.${timestamp}"
    if $DRY_RUN; then
      log_dry "Would back up: $dest → $backup"
    else
      log_info "Backing up: $dest → $backup"
      quiet mv "$dest" "$backup"
      echo "$backup" >>"$BACKUP_LOG"
    fi
  fi

  log_dry "Would symlink: $src → $dest"
  $DRY_RUN && return 0

  mkdir -p "$(dirname "$dest")"
  quiet ln -sf "$src" "$dest"
  log_success "Linked: $src → $dest"
}

symlink_files_for() {
  local prefix="$1" # can be "" or hosts/hostname_or_platform
  local home_dir=$(eval echo "~$TARGET_USER")

  local home_source config_source
  home_source="$AUTO_LINK_DIR/${prefix:+$prefix/}home"
  config_source="$AUTO_LINK_DIR/${prefix:+$prefix/}config"

  log_debug "Attempting to link home files from: '$home_source'"
  if [[ -d "$home_source" ]]; then
    local files_in_home_source=("$home_source"/*)

    if ((${#files_in_home_source[@]} > 0)); then
      for file in "${files_in_home_source[@]}"; do
        log_debug "Linking $file -> " "$home_dir/$(basename "$file")"
        should_skip "$file" && continue
        symlink_file "$file" "$home_dir/$(basename "$file")"
      done
    else
      log_info "No files found in home source directory: '$home_source'"
    fi
  fi

  log_debug "Attempting to link config files from: '$config_source'"
  if [[ -d "$config_source" ]]; then
    local files_in_config_source=("$config_source"/*)

    if ((${#files_in_config_source[@]} > 0)); then
      for file in "${files_in_config_source[@]}"; do
        should_skip "$file" && continue
        symlink_file "$file" "$home_dir/.config/$(basename "$file")"
      done
    else
      log_info "No files found in config source directory: '$config_source'"
    fi
  fi
}

symlink_files_for_custom() {
  for entry in "${CUSTOM_MAPPINGS[@]}"; do
    local src="$CUSTOM_LINKS_DIR/$(cut -d' ' -f1 <<<"$entry")"
    local dest="$(cut -d' ' -f2- <<<"$entry")"

    symlink_file "$src" "$dest"
  done
}

symlink_files() {
  symlink_files_for "shared"
  symlink_files_for "$PLATFORM"
  symlink_files_for "$HOSTNAME"

  symlink_files_for_custom
}

sanity_checks() {
  log_info "Running sanity checks..."

  if ! command -v paint &>/dev/null; then
    log_error "'paint' command not available. Make sure ./paint is a valid script that defines it."
    exit 1
  fi

  if ! id "$TARGET_USER" &>/dev/null; then
    log_error "Target user '$TARGET_USER' does not exist."
    exit 1
  fi

  local home_dir
  home_dir=$(eval echo "~$TARGET_USER")
  if [[ ! -w "$home_dir" ]]; then
    log_error "Home directory '$home_dir' for user '$TARGET_USER' is not writable."
    exit 1
  fi

  local required_dirs=("$AUTO_LINK_DIR" "$TOOLS_FILES_DIR" "$HOOKS_FILES_DIR")
  for dir in "${required_dirs[@]}"; do
    if [[ ! -d "$dir" ]]; then
      log_error "Required directory missing: $dir"
      exit 1
    fi
  done

  local required_cmds=(sudo bash ln grep xargs)
  for cmd in "${required_cmds[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
      log_error "Required command '$cmd' is not installed or not in PATH."
      exit 1
    fi
  done

  if [[ "$EUID" -ne 0 ]] && ! sudo -v &>/dev/null; then
    log_error "This script needs sudo access but sudo is not available or permission is denied."
    exit 1
  fi

  log_success "All sanity checks passed."
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
        log_dry "Would run hook: $hook"
      else
        log_info "Running $hook"
        source "$hook"
      fi
    fi
  done
}

run_hooks_for() {
  local prefix="$1" # can be "" or "hooks/hostname_or_platform"
  local post_hook="$HOOKS_FILES_DIR/${prefix:+$prefix}/post.sh"

  if [[ -d "$HOOKS_FILES_DIR/${prefix:+$prefix}/" ]]; then
    local files_in_hook_dir=("$HOOKS_FILES_DIR/${prefix:+$prefix}"/*)

    if ((${#files_in_hook_dir[@]} > 0)); then
      for file in "${files_in_hook_dir[@]}"; do
        # echo "$file"
        should_skip "$file" "pre.sh" "post.sh" && continue
        echo "post skp $file"
        if $DRY_RUN; then
          log_dry "Would run hook: $file"
        else
          log_info "Running $file"
          source "$file"
        fi
      done
    fi
  fi

  if [[ -f "$post_hook" ]]; then
    if $DRY_RUN; then
      log_dry "Would run hook: $post_hook"
    else
      log_info "Running $post_hook"
      source "$post_hook"
    fi
  fi
}

run_all_hooks() {
  run_hooks_for "shared"
  run_hooks_for "$PLATFORM"
  run_hooks_for "$HOSTNAME"
}

clean_backups() {
  if [ "$CLEAN_BACKUPS" = false ]; then
    return
  fi

  if [[ ! -s "$BACKUP_LOG" ]]; then
    log_info "No backups to clean. Log file does not exist or is empty."
    return
  fi

  log_info "Cleaning backups listed in: $BACKUP_LOG"

  local deleted_count=0
  local skipped_count=0

  local temp_backup_list=$(mktemp)
  cp "$BACKUP_LOG" "$temp_backup_list"

  while IFS= read -r backup; do
    if [[ -e "$backup" ]]; then
      log_dry "Would remove $backup"
      $DRY_RUN && ((++skipped_count)) && continue

      if rm -rf "$backup"; then
        log_success "Deleted: $backup"
        ((++deleted_count))
      else
        log_error "Failed to delete: $backup (check permissions)"
      fi
    else
      log_info "Skipping non-existent backup: $backup"
      ((++skipped_count))
    fi
  done <"$temp_backup_list"

  rm -f "$temp_backup_list"

  if [[ -f "$BACKUP_LOG" ]]; then
    log_dry "Would remove $BACKUP_LOG"
    $DRY_RUN && return 0

    if rm -f "$BACKUP_LOG"; then
      log_success "Deleted backup log: $BACKUP_LOG"
    else
      log_error "Failed to delete backup log: $BACKUP_LOG (check permissions)"
    fi
  fi

  log_success "Cleanup process completed. Deleted $deleted_count backups, skipped $skipped_count non-existent."
}

print_usage() {
  cat <<EOF
Usage: $0 [options]

Options:
  --debug             Show full command output (stdout/stderr)
  --dry-run, -d       Simulate actions without making changes
  --clean-backups, -c Clean up backed up files and exit
  --user, -u USERNAME Setup files for a specific user (e.g. root)
  --help, -h          Show this help message and exit

Examples:
  $0 --dry-run --user root
  $0 --clean-backups
EOF
}

# ─── Argument Parsing ──────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case "$1" in
  --no-emoji) P_EMOJI=false ;;
  --dry-run | -d) DRY_RUN=true ;;
  --help | -h)
    print_usage
    exit 0
    ;;
  --user | -u)
    shift
    TARGET_USER="$1"
    ;;
  --clean-backups | -c) CLEAN_BACKUPS=true ;;
  --debug)
    DEBUG=true
    LOG_LEVEL=${LOG_LEVEL_DEBUG}
    ;;
  --quiet | -q)
    SILENT=true
    LOG_LEVEL=${LOG_LEVEL_NONE}
    ;;
  *)
    echo "Unknown option: $1"
    print_usage
    exit 1
    ;;
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

log_debug "Platform: $PLATFORM"
log_debug "Hostname: $HOSTNAME"

sanity_checks
run_pre_hooks
install_tools
symlink_files
run_all_hooks
install_pakgs

[[ -f "$BACKUP_LOG" ]] && log_info "Files backed up and not deleted yet -"
[[ -f "$BACKUP_LOG" ]] && [[ $LOG_LEVEL -ge $LOG_LEVEL_INFO ]] && cat "$BACKUP_LOG"
[[ -f "$BACKUP_LOG" ]] && log_info "run: ./setup.sh --clean-backups # to delete the backups"

log_info "Setup complete for user: $TARGET_USER"
