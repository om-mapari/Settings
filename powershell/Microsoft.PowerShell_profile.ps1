# Fast PowerShell Profile

# Disable profile load time message
$env:POWERSHELL_UPDATECHECK = 'Off'

# Admin Check
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$adminSuffix = if ($isAdmin) { " [ADMIN]" } else { "" }
$Host.UI.RawUI.WindowTitle = "PowerShell {0}$adminSuffix" -f $PSVersionTable.PSVersion.ToString()

# Editor
$EDITOR = 'code'

# File utilities
function touch($file) { "" | Out-File $file -Encoding ASCII }
function nf { param($name) New-Item -ItemType "file" -Path . -Name $name }
function mkcd { param($dir) mkdir $dir -Force; Set-Location $dir }
function ff($name) { Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName } }
function la { Get-ChildItem | Format-Table -AutoSize }
function ll { Get-ChildItem -Force | Format-Table -AutoSize }
function trash($path) {
    $fullPath = (Resolve-Path -Path $path).Path
    if (Test-Path $fullPath) {
        $item = Get-Item $fullPath
        $parentPath = if ($item.PSIsContainer) { $item.Parent.FullName } else { $item.DirectoryName }
        $shell = New-Object -ComObject 'Shell.Application'
        $shell.NameSpace($parentPath).ParseName($item.Name).InvokeVerb('delete')
    }
}

# Explorer shortcuts
# Set-Alias -Name o -Value ii
Set-Alias -Name e -Value ii

# Unix-like commands
Set-Alias -Name grep -Value rg
function df { get-volume }
function sed($file, $find, $replace) { (Get-Content $file).replace("$find", $replace) | Set-Content $file }
function which($name) { Get-Command $name | Select-Object -ExpandProperty Definition }
function head { param($Path, $n = 10) Get-Content $Path -Head $n }
function tail { param($Path, $n = 10, [switch]$f = $false) Get-Content $Path -Tail $n -Wait:$f }
function unzip($file) { Expand-Archive -Path $file -DestinationPath $pwd }

# Process management
function pkill($name) { Get-Process $name -ErrorAction SilentlyContinue | Stop-Process }
function pgrep($name) { Get-Process $name }
function k9 { Stop-Process -Name $args[0] }

# System utilities
function admin { if ($args.Count -gt 0) { Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $($args -join ' ')" } else { Start-Process wt -Verb runAs } }
Set-Alias -Name su -Value admin
function uptime { $boot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime; $up = (Get-Date) - $boot; Write-Host "Uptime: $($up.Days)d $($up.Hours)h $($up.Minutes)m" -ForegroundColor Blue }
function sysinfo { Get-ComputerInfo }
function pubip { (Invoke-WebRequest http://ifconfig.me/ip).Content }
function flushdns { Clear-DnsClientCache; Write-Host "DNS flushed" }

# Clipboard
function cpy { Set-Clipboard $args[0] }
function pst { Get-Clipboard }

# Git shortcuts
function gs { git status }
function ga { git add . }
function gc { param($m) git commit -m "$m" }
function gpush { git push }
function gpull { git pull }
function gcl { git clone "$args" }
function gcom { git add .; git commit -m "$args" }
function lazyg { git add .; git commit -m "$args"; git push }
function g { __zoxide_z github }

# PSReadLine Configuration
$PSReadLineOptions = @{
    EditMode = 'Windows'
    HistoryNoDuplicates = $true
    HistorySearchCursorMovesToEnd = $true
    Colors = @{
        Command = '#87CEEB'; Parameter = '#98FB98'; Operator = '#FFB6C1'
        Variable = '#DDA0DD'; String = '#FFDAB9'; Number = '#B0E0E6'
        Type = '#F0E68C'; Comment = '#D3D3D3'; Keyword = '#8367c7'; Error = '#FF6347'
    }
    BellStyle = 'None'
}

# Add prediction features only for PSReadLine 2.1.0+ (PowerShell 7+)
$psReadLineVersion = (Get-Module PSReadLine).Version
if ($psReadLineVersion -ge [version]'2.1.0') {
    $PSReadLineOptions['PredictionSource'] = 'History'
    $PSReadLineOptions['PredictionViewStyle'] = 'ListView'
}

Set-PSReadLineOption @PSReadLineOptions

# Set additional options with version check
if ($psReadLineVersion -ge [version]'2.1.0') {
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin -MaximumHistoryCount 10000
} else {
    Set-PSReadLineOption -MaximumHistoryCount 10000
}

# Key handlers
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord 'Alt+d' -Function DeleteWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+z' -Function Undo
Set-PSReadLineKeyHandler -Chord 'Ctrl+y' -Function Redo

# Don't save sensitive commands to history
Set-PSReadLineOption -AddToHistoryHandler {
    param($line)
    $sensitive = @('password', 'secret', 'token', 'apikey', 'connectionstring')
    return ($null -eq ($sensitive | Where-Object { $line -match $_ }))
}

# Tab completions
$scriptblock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    $completions = @{
        'git' = @('status', 'add', 'commit', 'push', 'pull', 'clone', 'checkout', 'branch', 'merge', 'rebase', 'log', 'diff', 'stash', 'tag', 'fetch', 'remote')
        'npm' = @('install', 'start', 'run', 'test', 'build', 'init', 'update', 'uninstall', 'publish', 'audit')
        'kubectl' = @('get', 'describe', 'logs', 'apply', 'delete', 'exec', 'create', 'edit', 'scale', 'rollout', 'port-forward', 'top', 'explain', 'config', 'cluster-info')
        'k' = @('get', 'describe', 'logs', 'apply', 'delete', 'exec', 'create', 'edit', 'scale', 'rollout', 'port-forward', 'top', 'explain', 'config', 'cluster-info')
        'terraform' = @('init', 'plan', 'apply', 'destroy', 'validate', 'fmt', 'output', 'show', 'state', 'import', 'refresh', 'workspace', 'taint', 'untaint')
        'tf' = @('init', 'plan', 'apply', 'destroy', 'validate', 'fmt', 'output', 'show', 'state', 'import', 'refresh', 'workspace', 'taint', 'untaint')
        'aws' = @('s3', 'ec2', 'lambda', 'iam', 'cloudformation', 'rds', 'dynamodb', 'ecs', 'eks', 'configure', 'sts', 'logs', 'ssm', 'secretsmanager')
        'docker' = @('run', 'ps', 'images', 'build', 'pull', 'push', 'stop', 'start', 'restart', 'rm', 'rmi', 'exec', 'logs', 'inspect', 'compose', 'network', 'volume')
        'bun' = @('install', 'add', 'remove', 'run', 'test', 'build', 'create', 'init', 'update', 'upgrade', 'link', 'unlink', 'pm')
        'uv' = @('init', 'add', 'remove', 'sync', 'lock', 'run', 'tool', 'python', 'pip', 'venv', 'build', 'publish', 'cache', 'self')
        'uvx' = @('--help', '--version', '--from', '--with', '--python', '--isolated')
    }
    $cmd = $commandAst.CommandElements[0].Value
    if ($completions.ContainsKey($cmd)) { $completions[$cmd] | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) } }
}
Register-ArgumentCompleter -Native -CommandName git, npm, kubectl, k, terraform, tf, aws, docker, bun, uv, uvx -ScriptBlock $scriptblock

# Starship prompt
if (Get-Command starship -ErrorAction SilentlyContinue) { 
    $ENV:STARSHIP_CONFIG = "$PSScriptRoot\starship.toml"
    Invoke-Expression (&starship init powershell)
}

# Zoxide
$zoxideExe = "C:\Users\mapar\AppData\Local\Microsoft\WinGet\Packages\ajeetdsouza.zoxide_Microsoft.Winget.Source_8wekyb3d8bbwe\zoxide.exe"
$zoxideCachePath = Join-Path $PSScriptRoot "zoxide-init.ps1"
if (-not (Get-Command zoxide -ErrorAction SilentlyContinue) -and (Test-Path $zoxideExe)) { $env:Path += ";$(Split-Path $zoxideExe)" }
if (-not (Test-Path $zoxideCachePath) -and (Get-Command zoxide -ErrorAction SilentlyContinue)) { zoxide init --cmd z powershell | Out-File $zoxideCachePath -Encoding utf8 }
if (Test-Path $zoxideCachePath) { . $zoxideCachePath }

# Help
function Show-Help {
    Write-Host "`nGit: " -NoNewline -ForegroundColor Cyan; Write-Host "gs ga gc gpush gpull gcl gcom lazyg g"
    Write-Host "File: " -NoNewline -ForegroundColor Cyan; Write-Host "touch nf mkcd ff la ll trash z"
    Write-Host "Unix: " -NoNewline -ForegroundColor Cyan; Write-Host "head tail grep sed which df unzip"
    Write-Host "Proc: " -NoNewline -ForegroundColor Cyan; Write-Host "pgrep pkill k9"
    Write-Host "Sys:  " -NoNewline -ForegroundColor Cyan; Write-Host "admin/su uptime sysinfo pubip flushdns cpy pst"
    Write-Host "Keys: " -NoNewline -ForegroundColor Cyan; Write-Host "↑/↓ history | Tab complete | Ctrl+Z undo | Ctrl+Y redo`n"
}
