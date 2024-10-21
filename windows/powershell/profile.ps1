using namespace System.Management.Automation

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Register-ArgumentCompleter -CommandName ssh,scp,sftp -Native -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $knownHosts = Get-Content ${Env:HOMEPATH}\.ssh\config `
    | Select-String -Pattern "^Host " `
    | ForEach-Object { $_ -replace "host ", "" } `
    | Sort-Object -Unique

    # For now just assume it's a hostname.
    $textToComplete = $wordToComplete
    $generateCompletionText = {
        param($x)
        $x
    }
    if ($wordToComplete -match "^(?<user>[-\w/\\]+)@(?<host>[-.\w]+)$") {
        $textToComplete = $Matches["host"]
        $generateCompletionText = {
            param($hostname)
            $Matches["user"] + "@" + $hostname
        }
    }

    $knownHosts `
    | Where-Object { $_ -like "${textToComplete}*" } `
    | ForEach-Object { [CompletionResult]::new((&$generateCompletionText($_)), $_, [CompletionResultType]::ParameterValue, $_) }
}

$ENV:STARSHIP_CONFIG = "C:\Users\gbsal\starship.toml"
Invoke-Expression (&starship init powershell)


#$Aliases = @{ gs = "git status"; grv = "git remote -v"; }
#function RunAlias {
#    param (
#        $Alias
#    )
#    
#    Invoke-Expression $Aliases[$Alias]
#}
#foreach ($Key in $Aliases.Keys) {
#    "The value of '$Key' is: $($Aliases[$Key])"
#}

Set-Alias nv nvim -Force -Option AllScope

function msc {
    Set-Location "D:\linx\.sysman"
}

function ll {
    Get-ChildItem -Force
}

function nrd { npm run dev }
function nrs { npm run start }

# git commands
Remove-Item Alias:gc -Force
Remove-Item Alias:gm -Force
Remove-Item Alias:gl -Force
function ga { git add -A }
function gs { git status $args }
function gb { git branch $args }
function gc { git checkout $args }
function cm { git commit -m $args }
function gl { git log --all --graph --decorate }
function grv { git remote -v }




