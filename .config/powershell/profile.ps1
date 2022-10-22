using namespace Microsoft.PowerShell

function _on_windows() {
    # Should work on PowerShell 5+
    return $IsWindows -or $env:OS -eq 'Windows_NT'
}

### Environnment ###

$PSReadLineOptions = @{
    BellStyle = 'None'
    HistoryNoDuplicates = $true
    PredictionSource = 'History'
    Colors = @{
        'InlinePrediction' = "`e[90m"
        'Number' = "`e[94m"
        'Operator' = "`e[36m"
        'Parameter' = "`e[35m"
    }
}
Set-PSReadLineOption @PSReadLineOptions

# Keybinds

$appendPipe = {
    param ($key, $arg)

    $char = @{ f = '%'; w = '?' }[[string]$key.KeyChar]
    $line, $curpos = $null, $null
    [PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$curpos)

    if ($line[-1] -ne ' ') {
        [PSConsoleReadLine]::Insert(' ')
    }
    [PSConsoleReadLine]::Insert("| $char {  }")
    [PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$curpos)
    [PSConsoleReadLine]::SetCursorPosition($line.Length - 2)
}

$keybinds = @{
    WrapBufferInParens = @{
        Chord = 'Ctrl+p'
        BriefDescription = 'WrapBufferInParens'
        Description = 'Wrap the entire command line in parentheses'
        ScriptBlock = {
            param ($key, $arg)

            $line, $curpos = $null, $null
            [PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$curpos)

            [PSConsoleReadLine]::SetCursorPosition(0)
            [PSConsoleReadLine]::Insert('(')
            [PSConsoleReadLine]::SetCursorPosition($line.Length + 1)
            [PSConsoleReadLine]::Insert(')')
        }
    }

    AppendForeachObj = @{
        Chord = 'Alt+f'
        BriefDescription = 'AppendForeachObj'
        Description = 'Appends a pipe to Foreach-Object and an open scriptblock'
        ScriptBlock = $appendPipe
    }

    AppendWhereObj = @{
        Chord = 'Alt+w'
        BriefDescription = 'AppendWhereObj'
        Description = 'Appends a pipe to Where-Object and an open scriptblock'
        ScriptBlock = $appendPipe
    }
}
$keybinds.Values | ForEach-Object { Set-PSReadLineKeyHandler @_ }

# I'm likely using VSCode/VSCodium if I'm on Windows, but if I happen to have
# Neovim set up, use that (via .git/config)
if (_on_windows) {
    foreach ($editor in @('codium', 'code')) {
        if (Get-Command -CommandType Application $editor -ErrorAction SilentlyContinue) {
            $env:GIT_EDITOR = "$editor -w"
            break
        }
    }
}

$env:BAT_CONFIG_DIR = "$env:USERPROFILE/.config/bat"

### Aliases ###

New-Alias which where.exe
New-Alias mklink New-Link
New-Alias g git

if (Get-Command -CommandType Application 'codium' -ErrorAction SilentlyContinue) {
    New-Alias code codium
}

### Functions ###

function New-Link ($target, $link) {
    if ($null -eq $link) {
        $link = ([System.IO.FileInfo] $target).Name
    }
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

# Clean up private functions
Get-ChildItem function: | Where-Object { $_.Name[0] -eq '_' } | Remove-Item
