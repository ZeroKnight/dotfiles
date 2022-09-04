function _on_windows() {
    # Should work on PowerShell 5+
    if ($IsWindows -or $env:OS -eq 'Windows_NT') {
        return $true
    }
    return $false
}

### Environnment ###

$PSReadLineOptions = @{
    BellStyle = 'None'
    HistoryNoDuplicates = $true
    Colors = @{
        'InlinePrediction' = "`e[90m"
        'Number' = "`e[94m"
        'Operator' = "`e[36m"
        'Parameter' = "`e[35m"
    }
}
Set-PSReadLineOption @PSReadLineOptions

# I'm likely using VSCode/VSCodium if I'm on Windows, but if I happen to have
# Neovim set up, use that (via .git/config)
if (_on_windows) {
    foreach ($editor in @('codium', 'code')) {
        if (Get-Command $editor -ErrorAction SilentlyContinue) {
            $env:GIT_EDITOR = $editor
            break
        }
    }
}

$env:BAT_CONFIG_DIR = "$env:USERPROFILE/.config/bat"

### Aliases ###

New-Alias which where.exe
New-Alias mklink New-Link
New-Alias g git
New-Alias code codium

### Functions ###

function New-Link ($target, $link) {
    if ($null -eq $link) {
        $link = ([System.IO.FileInfo] $target).Name
    }
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

# Clean up private functions
Get-ChildItem function: | Where-Object { $_.Name[0] -eq '_' } | Remove-Item
