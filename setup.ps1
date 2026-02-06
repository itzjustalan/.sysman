# ─── Parameters ─────────────────────────────────────────────────────────

param (
    [switch]$NoInstall,
    [switch]$Clean,
    [switch]$DryRun,
    [switch]$Help
)

# ─── Sanity Checks ──────────────────────────────────────────────────────

if ($PSVersionTable.PSVersion.Major -ge 6) {
    if ($IsLinux -or $IsMacOS) {
        Write-Error "This script is intended to run on Windows only. Use ./setup.sh for bash."
        exit 1
    }
} else {
    if ($env:OS -ne "Windows_NT") {
        Write-Error "This script is intended to run on Windows only. Use ./setup.sh for bash."
        exit 1
    }
}

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole] "Administrator")

if (-not $isAdmin) {
    Write-Host "Elevating to administrator..."
    $scriptPath = $MyInvocation.MyCommand.Definition
    $scriptDir = Split-Path -Parent $scriptPath
    $argList = @()

    if ($NoInstall) { $argList += "-NoInstall" }
    if ($Clean)     { $argList += "-Clean" }
    if ($DryRun)    { $argList += "-DryRun" }
    if ($Help)      { $argList += "-Help" }

    Start-Process powershell -Verb RunAs -ArgumentList "-NoExit -NoProfile -ExecutionPolicy Bypass -Command `"cd `"$scriptDir`"; & `"$scriptPath`" $($argList -join ' ')`""
    exit 0
}

if (-not (Get-Command "winget" -ErrorAction SilentlyContinue)) {
    Write-Warning "winget not found. Attempting to install via Microsoft Store..."

    $appInstallerUri = "ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1"
    Start-Process $appInstallerUri

    Write-Host "Please install App Installer from the Microsoft Store and re-run this script."
    exit 1
}

# ─── Configuration ──────────────────────────────────────────────────────

$AppName = "sysman"
$ProjectDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ToolsListPath = Join-Path $ProjectDir "windows\tools\winget.json"
$BackupLog = Join-Path $ProjectDir ".$AppName-backups.txt"

$DesktopDir = [Environment]::GetFolderPath("Desktop")                         # C:\Users\user\[OneDrive]\Desktop
$DocumentsDir = [Environment]::GetFolderPath("MyDocuments")                   # C:\Users\user\[OneDrive]\Documents
$RoamingDir = [Environment]::GetFolderPath("ApplicationData")                 # C:\Users\user\AppData\Roaming
$LocalAppDataDir = [Environment]::GetFolderPath("LocalApplicationData")       # C:\Users\user\AppData\Local

$CustomLinks = @(
    @{
        Source      = Join-Path $ProjectDir "links\shared\config\nvim"
        Destination = Join-Path $LocalAppDataDir "nvim"
    },
    @{
        Source      = Join-Path $ProjectDir "windows\vscode\settings.json"
        Destination = Join-Path $RoamingDir "Code\User\settings.json"
    },
    @{
        Source      = Join-Path $ProjectDir "windows\windows_terminal\settings.json"
        Destination = Join-Path $LocalAppDataDir "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    },
    @{
        Source      = Join-Path $ProjectDir "windows\winget\settings.json"
        Destination = Join-Path $LocalAppDataDir "Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"
    },
    @{
        Source      = Join-Path $ProjectDir "windows\powershell\profile.ps1"
        Destination = Join-Path $DocumentsDir "WindowsPowerShell\profile.ps1"
    }
)

# ─── Functions ──────────────────────────────────────────────────────────

function Install-Tools {

    if (-not (Test-Path $ToolsListPath)) {
        Write-Error "Tools list not found: $ToolsListPath"
        return
    }

    Write-Host "Importing tools via winget..."
    if ($DryRun) {
        Write-Host "DRY RUN: Would install tools with WinGet"
        return
    }

    $WingetArgs = @(
        "import"
        "-i", $ToolsListPath                             # Specifies the JSON file to import
        "--accept-source-agreements"                     # Accept source license agreements
        "--accept-package-agreements"                    # Accept package license agreements
        "--disable-interactivity"                        # Disable interactive prompts
        "--ignore-warnings"                              # Suppress warning outputs
        "--no-upgrade"                                   # Skip upgrades if version already exists
        "--ignore-versions"                              # Ignore specified versions and install latest version
        "--ignore-unavailable"                           # Suppress errors if a package is unavailable
    )

    winget @WingetArgs
}

function Link-File {
    param (
        [string]$Source,
        [string]$Destination
    )

    if (-not (Test-Path $Source)) {
        Write-Error "Source does not exist: $Source"
        return
    }

    if (Test-Path $Destination) {
        $destItem = Get-Item $Destination -Force
        $isSymlink = $destItem.Attributes -band [IO.FileAttributes]::ReparsePoint

        if ($isSymlink) {
            $resolvedSource = (Resolve-Path $Source).Path
            $resolvedTarget = (Resolve-Path $destItem.Target).Path

            if ($resolvedSource -eq $resolvedTarget) {
                Write-Host "Already linked: $Destination -> $Source"
                return
            }
        }

        # Backup existing item
        $backupPath = "$Destination.backup.$((Get-Date).ToString('yyyyMMddHHmmss'))"
        if ($DryRun) {
            Write-Host "DRY RUN: Would backup $Destination to $backupPath"
        } else {
            Move-Item $Destination $backupPath -Force
            Add-Content -Path $BackupLog -Value $backupPath
            Write-Host "Backed up: $Destination -> $backupPath"
        }
    }

    # Ensure parent directory exists
    $parentDir = Split-Path $Destination -Parent
    if (-not (Test-Path $parentDir)) {
        if ($DryRun) {
            Write-Host "DRY RUN: Would create directory $parentDir"
        } else {
            New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
        }
    }

    # Create symlink
    if ($DryRun) {
        Write-Host "DRY RUN: Would link $Source -> $Destination"
    } else {
        New-Item -ItemType SymbolicLink -Path $Destination -Target $Source -Force | Out-Null
        Write-Host "Linked: $Source -> $Destination"
    }
}

function Link-All-Custom-Links {
    foreach ($mapping in $CustomLinks) {
        Link-File -Source $mapping.Source -Destination $mapping.Destination
    }
}

function Clean-Backups {
    if (-not (Test-Path $BackupLog)) {
        Write-Host "No backup log found. Nothing to clean."
        return
    }

    $backups = Get-Content $BackupLog
    foreach ($backup in $backups) {
        if (Test-Path $backup) {
            if ($DryRun) {
                Write-Host "DRY RUN: Would delete $backup"
            } else {
                Remove-Item $backup -Force -Recurse
                Write-Host "Deleted backup: $backup"
            }
        } else {
            Write-Host "Backup not found (skipped): $backup"
        }
    }

    if ($DryRun) {
        Write-Host "DRY RUN: Would remove backup log: $BackupLog"
    } else {
        Remove-Item $BackupLog -Force
        Write-Host "Backup log removed."
    }
}

function Print-Usage {
    Write-Host @"
Usage: .\setup.ps1 [options]

Options:
  -NoInstall    Do NOT install tools via winget (default is to install)
  -DryRun       Simulate actions without making changes
  -Clean        Remove all backed up files
  -Help         Show this help message

Examples:
  .\setup.ps1
  .\setup.ps1 -NoInstall     Simply link missing links
  .\setup.ps1 -DryRun        Simulates safely without executing
  .\setup.ps1 -Clean         Clean the backups and exit
  .\setup.ps1 -Help          Show this help message
"@
}

# ─── Main ───────────────────────────────────────────────────────────────

if ($Help) {
    Print-Usage
    exit 0
}

if ($Clean) {
    Clean-Backups
    exit 0
}

Write-Host "`n`n -=[ $AppName ]=-`n"

if (-not $NoInstall) {
    Install-Tools
}

Link-All-Custom-Links

if (Test-Path $BackupLog) {
    Write-Host "`nFollowing backups are waiting to be removed.`n"

    Get-Content $BackupLog | ForEach-Object { Write-Host "  $_" }

    Write-Host "`n`nrun: `n.\setup.ps1 -clean # to remove the backed up files"
}

