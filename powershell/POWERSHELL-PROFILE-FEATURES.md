# PowerShell Profile Features

Based on Chris Titus Tech's profile, optimized for fast startup (~763ms).

## Performance Optimizations Applied

| Optimization | Time Saved |
|--------------|------------|
| Lazy GitHub connectivity check | ~1000ms |
| Removed auto-update checks on startup | ~500ms |
| Switched from Oh My Posh to Starship | ~300ms |
| Cached zoxide initialization | ~100ms |
| Hardcoded editor (no detection loop) | ~50ms |
| Removed module installation checks | ~100ms |

---

## Prompt & Shell

| Feature | Description |
|---------|-------------|
| **Starship** | Fast, customizable prompt (Rust-based) |
| **Zoxide** | Smart `cd` command - learns your habits (`z` to jump) |
| **Admin indicator** | Window title shows `[ADMIN]` when elevated |

---

## Keyboard Shortcuts (PSReadLine)

| Shortcut | Action |
|----------|--------|
| `↑` / `↓` | Search history (type partial command first) |
| `Tab` | Menu-style completion |
| `Ctrl+Z` | Undo |
| `Ctrl+Y` | Redo |
| `Ctrl+D` | Delete character |
| `Ctrl+W` | Delete word backward |
| `Alt+D` | Delete word forward |
| `Ctrl+←` / `Ctrl+→` | Jump by word |

---

## Git Shortcuts

| Command | Action |
|---------|--------|
| `gs` | `git status` |
| `ga` | `git add .` |
| `gc "msg"` | `git commit -m "msg"` |
| `gpush` | `git push` |
| `gpull` | `git pull` |
| `gcl <url>` | `git clone <url>` |
| `gcom "msg"` | `git add . && git commit -m "msg"` |
| `lazyg "msg"` | Add, commit, and push in one command |
| `g` | Jump to GitHub directory (via zoxide) |

---

## File & Directory Commands

| Command | Action |
|---------|--------|
| `touch <file>` | Create empty file |
| `nf <name>` | Create new file |
| `mkcd <dir>` | Create directory and cd into it |
| `ff <name>` | Find files recursively by name |
| `la` | List files (formatted table) |
| `ll` | List all files including hidden |
| `unzip <file>` | Extract zip to current directory |
| `trash <path>` | Move to Recycle Bin |
| `z <partial>` | Smart cd (zoxide) |

---

## Text Processing (Unix-like)

| Command | Action |
|---------|--------|
| `head <file> [n]` | First n lines (default 10) |
| `tail <file> [n]` | Last n lines (default 10) |
| `tail <file> -f` | Follow file (like `tail -f`) |
| `grep <regex> [dir]` | Search for pattern in files |
| `sed <file> <find> <replace>` | Find and replace in file |
| `which <cmd>` | Show command path |

---

## Process Management

| Command | Action |
|---------|--------|
| `pgrep <name>` | List processes by name |
| `pkill <name>` | Kill processes by name |
| `k9 <name>` | Kill process (alias) |

---

## System Utilities

| Command | Action |
|---------|--------|
| `admin` / `su` | Open elevated PowerShell |
| `uptime` | Show system uptime |
| `sysinfo` | Detailed system information |
| `df` | Show disk volumes |
| `Clear-Cache` | Clear Windows temp/prefetch/cache |

---

## Network Utilities

| Command | Action |
|---------|--------|
| `pubip` | Get public IP address |
| `flushdns` | Clear DNS cache |

---

## Clipboard

| Command | Action |
|---------|--------|
| `cpy <text>` | Copy to clipboard |
| `pst` | Paste from clipboard |

---

## Auto-Completions

Custom tab completions for:
- `git` - status, add, commit, push, pull, clone, checkout
- `npm` - install, start, run, test, build
- `deno` - run, compile, bundle, test, lint, fmt, cache, info, doc, upgrade
- `dotnet` - full completion support

---

## Syntax Highlighting Colors (Pastel Theme)

| Element | Color |
|---------|-------|
| Command | SkyBlue |
| Parameter | PaleGreen |
| Operator | LightPink |
| Variable | Plum |
| String | PeachPuff |
| Number | PowderBlue |
| Type | Khaki |
| Comment | LightGray |
| Keyword | Violet |
| Error | Tomato |

---

## Security Features

- Sensitive commands (password, token, apikey, secret) excluded from history
- Telemetry opt-out when running as admin
- Lazy network checks (no startup pings)

---

## Customization

Override any function by creating `<FunctionName>_Override` in your profile:
- `$EDITOR_Override` - Change default editor
- `$debug_Override` - Enable debug mode
- `Get-Theme_Override` - Custom prompt theme
- `Update-Profile_Override` - Custom update logic

---

## Load Time Breakdown (~763ms)

| Component | Time |
|-----------|------|
| Starship prompt | ~275ms |
| PSReadLine setup | ~275ms |
| Zoxide | ~70ms |
| Key handlers | ~50ms |
| Arg completers | ~40ms |
| Other | ~50ms |
