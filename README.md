sed -i 's/^M//g' file
sed -i 's/\r//g' file

# for win11
```cmd
mklink C:\Users\{username}\Documents\WindowsPowerShell\profile.ps1 D:\linx\.sysman\windows\powershell\profile.ps1
mklink /d C:\Users\user\AppData\Local\nvim D:\.sysman\links\shared\config\nvim
```


````markdown
# 🛠️ Sysman - Setup System

A cross-platform, host-aware, extensible dotfiles system designed to configure development environments for:

- 🐧 Linux (Arch, Debian, Ubuntu, etc.)
- 🍏 macOS
- 🪟 Windows WSL
- 🧑‍💻 Root or alternate users
- 🎯 Multiple hosts (laptop, desktop, VM, etc.)

## 📁 Directory Structure

```text
dotfiles/
├── setup.sh                     # Main entrypoint
├── config/                      # Shared ~/.config files
│   ├── nvim/
│   └── tmux/
├── home/                        # Files linked directly to ~/
│   └── .bashrc
├── custom/                      # Custom-mapped files (paths hardcoded in setup)
│   └── somedir/special.conf
├── platform/			  # Platform specific overrides
│   ├── ubuntu/
│   │   └── config/
│   ├── macos/
│   │   └── config/
├── tools/
│   ├── ubuntu.txt
│   ├── macos.txt
│   └── wsl.txt
├── hooks/			  # Pre and Post Hooks
│   ├── platform/
│   │   ├── ubuntu.pre.sh
│   │   └── macos.post.sh
│   └── host/
│       ├── my-laptop.pre.sh
│       └── work-desktop.post.sh
└── README.md			  # This Readme file
````

## 🚀 Usage

```bash
./setup.sh [--verbose] [--debug] [--user USERNAME]
```

### Flags:

| Flag               | Description                                         |
| ------------------ | --------------------------------------------------- |
| `--debug`          | Show raw command output (stdout/stderr) on terminal |
| `--dry-run`          | Test without making changes |
| `--verbose` / `-v` | Show human-readable status logs on terminal         |
| `--user USER`      | Target a different user (e.g., `root`, `deploy`)    |
| `--help` / `-h`    | Print usage instructions                            |


## 🔗 What It Does

### ✅ Symlinks dotfiles

* `home/*` → `~/.filename`
* `config/*` → `~/.config/dirname`
* `custom/*` → Hardcoded destinations
* `platform/*/config/*` → Overrides for matching OS

### ✅ Backs up existing files

If a file already exists, it is **moved** with a timestamp:

```bash
.bashrc → .bashrc.backup.20250522094530
```

### ✅ Detects platform

Supported:

* `debian`, `arch`, etc.
* `macos`
* `wsl`
* Default fallback: `linux`, `unknown`

### ✅ Installs tools

Reads from:

```text
tools/debian.txt
tools/macos.txt
tools/wsl.txt
```

Installs using the first available package manager:

* `apt`, `dnf`, `pacman`, `brew`, `apk`

### ✅ Runs platform/host hooks

Custom per-environment setup:

```bash
hooks/platform/debian.sh     # Runs for Debian
hooks/host/my-laptop.sh      # Runs for specific hostname
```


## 📝 Logs

All runs are logged to:

```bash
~/.dotfiles-setup.log
```

| Mode      | Terminal Output    | Log Output |
| --------- | ------------------ | ---------- |
| default   | silent             | ✅          |
| `-v`      | info messages      | ✅          |
| `--debug` | full stdout/stderr | ✅          |


## 🧩 Extending It

### ➕ Add Tools

Create or edit:

```bash
tools/debian.txt
tools/macos.txt
tools/wsl.txt
```

One tool per line.


### ➕ Add New Configs

| Target directory     | Symlinks to                           |
| -------------------- | ------------------------------------- |
| `home/xyz`           | `~/.xyz`                              |
| `config/abc/`        | `~/.config/abc/`                      |
| `platform/*/config/` | Platform-specific `.config` overrides |


### ➕ Add Custom Mappings

Add files under `custom/` and define paths directly in `setup.sh`:

```bash
symlink_file "$DOTFILES_DIR/custom/somedir/special.conf" "/etc/special.conf"
```


### ➕ Add New Platform or Host Hooks

```bash
# New platform
touch hooks/platform/arch.pre.sh

# New host
touch hooks/host/hostname123.post.sh
```



## ♻️ Maintenance

* ✅ Update `tools/<platform>.txt` as the setup evolves
* ✅ Keep overrides minimal — most config should be shared


### 🧪 Dry-Run Mode

Test the setup without making changes:

```bash
./setup.sh --dry-run --verbose

## 💡 Tips

* Run as root to configure root user too:

  ```bash
  sudo ./setup.sh --user root --verbose
  ```

