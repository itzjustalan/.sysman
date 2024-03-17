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
    Set-Location "D:\work\rkd\identity.charitable.one"
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
function gm { git commit -m }
function gl { git log --all --graph --decorate }
function grv { git remote -v }
