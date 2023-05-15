# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
 Import-Module "$ChocolateyProfile"
}

# Oh My POSH Settings
oh-my-posh init pwsh --config $env:POSH_THEMES_PATH/blue-owl.omp.json | Invoke-Expression
Enable-PoshTransientPrompt

# Load modules
# Import-Module "C:\Program Files\gsudo\Current\gsudoModule.psd1"
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -ShowToolTips

# su
function Open-Admin {
    $currPath = Get-Location
    Start-Process -Verb RunAs cmd.exe "/c start wt.exe -d $currPath"
}

function Get-GgpKeys {
    param(
        [string]$ExportParam
    )

    if ($ExportParam) {
        gpg --armor --export $ExportParam
    } else {
        gpg --list-secret-keys --keyid-format=long 
    }
}

function Clip-WorkingDirectory {
    $pwd | Select-Object -ExpandProperty Path | Set-Clipboard
}

Set-Alias su Open-Admin
Set-Alias gpg-keys Get-GPGKeys
Set-Alias cds Set-SpecialLocation
Set-Alias which Get-Command
Set-Alias ccd Clip-WorkingDirectory
