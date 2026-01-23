# PowerShell Profile Setup

Fast PowerShell profile with Unix-like commands, Git shortcuts, and modern enhancements.

See [POWERSHELL-PROFILE-FEATURES.md](POWERSHELL-PROFILE-FEATURES.md) for complete feature list.

## Prerequisites

**Required:**
```powershell
# Modern PowerShell (v7+)
winget install Microsoft.PowerShell

# Cross-shell prompt with Git integration
winget install Starship.Starship

# Smart directory jumping (z command)
winget install ajeetdsouza.zoxide

# Fast search tool (grep alias)
winget install BurntSushi.ripgrep.MSVC

# Version control
winget install Git.Git
```

## Installation

```powershell
# Copy profile
Copy-Item "Microsoft.PowerShell_profile.ps1" $PROFILE -Force

# Copy starship config
Copy-Item "starship.toml" (Split-Path $PROFILE) -Force

# Reload
. $PROFILE
```

## Troubleshooting

**Execution policy error:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Commands not found:** Restart terminal after installing prerequisites.
