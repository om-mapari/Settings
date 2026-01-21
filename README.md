# 🚀 The Ultimate Windows Dev Setup (That Actually Doesn't Suck)

> *"I spent 7 years in the trenches configuring this so you don't have to suffer through Windows defaults"*

Welcome to my digital dojo. This is where Windows meets productivity, where bloat goes to die, and where your terminal finally looks like it belongs in 2026. Clone this, copy the configs, and ascend to power user status in under an hour.

## � The Arsenal

| Tool | What It Does (In Human) |
|------|-------------|
| **[PowerShell](powershell/)** | Your terminal but on steroids. Blazing fast because life's too short |
| **[WindHawk](WindHawk/)** | Makes Windows 11 look less like a Fisher-Price toy |
| **[VSCode](vscode/)** | Where the magic happens. JetBrains Mono because we're fancy |
| **[Git](git/)** | SSH keys, configs, and the ability to `git push --force` with confidence |
| **[Sublime Text](sublime/)** | For when VSCode is being dramatic |
| **[VLC](vlc-media-player/)** | Dark mode VLC because your eyes deserve better |
| **[FlowLauncher](FlowLauncher/)** | Alt+Space to summon anything. Spotlight who? |
| **[Espanso](Espanso/)** | Type `;;shrug` get `¯\_(ツ)_/¯`. You're welcome |
| **[Fonts](fonts/)** | JetBrains Mono Nerd Font. Ligatures that make you feel smart |
| **[Winutil](Winutil/)** | Chris Titus's Windows debloater. Cortana? Never heard of her |

## 🎯 The "I Just Wiped My PC" Speedrun

### Level 1: Get The Good Stuff
```powershell
# First, get a real package manager
winget install marticliment.UniGetUI

# The essentials (aka the bare minimum to be productive)
winget install Microsoft.PowerShell      # PowerShell 7, not that ancient 5.1 thing
winget install Starship.Starship         # Prompt so pretty you'll screenshot it
winget install ajeetdsouza.zoxide        # cd but it reads your mind
winget install Git.Git                   # You know what this is
winget install Microsoft.VisualStudioCode # The one true editor (fight me)
```

### Level 2: PowerShell Goes Brrr
```powershell
# Copy the good stuff
Copy-Item "powershell/Microsoft.PowerShell_profile.ps1" $PROFILE -Force
Copy-Item "powershell/starship.toml" (Split-Path $PROFILE) -Force

# Reload and watch the magic
. $PROFILE

# Now you can do cool stuff like:
# gs          → git status
# lazyg "yolo" → git add . && commit && push (the true dev experience)
# z github    → teleports to your github folder
```

### Level 3: Git Like You Mean It
```bash
# Tell Git who you are (or who you pretend to be)
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global credential.helper manager

# Generate SSH key (smash Enter through all prompts)
ssh-keygen -t ed25519 -C "your@email.com"

# Copy this bad boy to GitHub
cat ~/.ssh/id_ed25519.pub

# Test if GitHub recognizes you
ssh -T git@github.com
# "Hi username!" ← If you see this, you're in
```

### Level 4: VSCode But Better
```powershell
# Deploy the configs
Copy-Item "vscode/settings.json" "$env:APPDATA\Code\User\" -Force
Copy-Item "vscode/keybindings.json" "$env:APPDATA\Code\User\" -Force

# Restart VSCode and enjoy:
# - JetBrains Mono with ligatures (because => looks better than =>)
# - GitHub Dark theme (your retinas will thank you)
# - Code Runner (F5 to run anything, anywhere)
# - No annoying confirmations (we live dangerously here)
```

## 🎨 Making Windows Look Less... Windows-y

### WindHawk: The UI Rebellion
Install [WindHawk](https://windhawk.net/) then grab these mods:

- **Windows 11 Taskbar Styler** - DockLike theme (macOS who?)
- **Start Menu Styler** - Because the default is an insult
- **Notification Center Styler** - Notifications that don't look like ads
- **Middle Click to Close** - Close taskbar apps like a boss
- **Taskbar Volume Control** - Scroll on taskbar to adjust volume (mind = blown)
- **Better File Sizes** - "1.5 GB" instead of "1,572,864 KB" (thank you)

### Windows Tweaks (The Nuclear Option)
```powershell
# Enable battery icon (because Microsoft hid it for... reasons?)
vivetool /enable /id:56328729,48433719

# Clear icon cache when Windows has a stroke
taskkill /IM explorer.exe /F
DEL /A /Q "%localappdata%\IconCache.db"
start explorer.exe
```

## 🛠️ The Toolkit (Apps That Don't Suck)

**Productivity Tier:**
- **UniGetUI** - All package managers in one place. Winget + Scoop + Chocolatey = ❤️
- **Obsidian** - Note-taking for people who think in graphs
- **FlowLauncher** - Alt+Space and summon anything. Faster than Windows Search (not hard)
- **Espanso** - Text expansion. Type less, do more, look like a wizard

**Dev Tier:**
- **VSCode** - You're already using it, let's be honest
- **Sublime Text 4** - For when you need speed and VSCode is being a RAM hog
- **Git + SSH** - Version control or it didn't happen
- **Windows Terminal** - The terminal Microsoft should've made 20 years ago

**System Tier:**
- **WindHawk** - Make Windows pretty without breaking it
- **Winutil** - Chris Titus's debloater. Removes the bloat, keeps the OS
- **RevoUninstaller** - Uninstall things like you mean it

## 💎 The Good Stuff (Features That'll Make You Smile)

### PowerShell Profile (The Terminal You Deserve)
- **Unix commands on Windows** - `grep`, `sed`, `tail`, `which` (Linux users: feel at home)
- **Git shortcuts** - `gs`, `ga`, `gc`, `lazyg` (commit messages are overrated anyway)
- **Zoxide** - `z github` teleports you there. No more `cd ../../..`
- **Tab completion** - Works for git, npm, docker, kubectl (press Tab, look smart)
- **Syntax highlighting** - Your commands now have RGB
- **Lightning fast** - Optimized to load faster than your coffee machine

### VSCode Config (The Setup Tax)
- **JetBrains Mono** - Ligatures that make `=>` look like →
- **GitHub Dark** - Because light mode is a war crime
- **Code Runner** - Run code without leaving the editor (F5 goes brrr)
- **No confirmations** - Delete files with confidence (or regret)
- **Better comments** - `// TODO` in orange, `// !` in red, `// ?` in blue
- **Git Bash terminal** - Because cmd.exe is from 1987

### WindHawk Customization (Windows 11 Makeover)
- **DockLike taskbar** - Centered, transparent, actually good-looking
- **Custom notifications** - No more Windows 10 vibes
- **Middle-click to close** - Close windows from taskbar like a power user
- **Volume scroll** - Scroll on taskbar = volume control (why isn't this default?)
- **Better file sizes** - See "1.5 GB" not "1,572,864 KB" (thank you, sanity)

## � The Map (Where Everything Lives)

```
Settings/
├── powershell/          # The terminal that sparks joy
├── WindHawk/            # Windows 11 but pretty
├── vscode/              # Editor configs (the good stuff)
├── git/                 # SSH keys and Git wizardry
├── sublime/             # The backup editor
├── vlc-media-player/    # Dark mode VLC (finally)
├── FlowLauncher/        # Alt+Space magic
├── Espanso/             # Text expansion sorcery
├── fonts/               # Nerd fonts (ligatures go brrr)
├── Winutil/             # Windows debloater
├── AppList.md           # Apps that don't suck
└── README.md            # You are here
```

## 🧠 The Philosophy

- **Fast AF** - If it takes >1 second to load, it's bloat
- **Keyboard > Mouse** - Touching the mouse is admitting defeat
- **Dark Mode Everything** - Light mode is for psychopaths
- **Automate or Die** - If you do it twice, script it
- **No Bloat** - Every feature must earn its place

## ⚠️ Warning Labels

- Backup your configs before copying (or don't, I'm not your mom)
- Some tweaks need admin rights (run as admin or cry)
- WindHawk mods can break on Windows updates (worth it)
- The `lazyg` command is dangerous in the right hands
- Once you use zoxide, regular `cd` feels like walking backwards

## 🎓 Pro Tips

1. **Learn the shortcuts** - `Show-Help` in PowerShell shows everything
2. **Customize the colors** - Edit `starship.toml` to match your vibe
3. **Add your own aliases** - Edit `$PROFILE` and go wild
4. **Use `z` everywhere** - After a week, it knows where you want to go
5. **Middle-click taskbar** - Close apps without right-clicking like a caveman

## 🙏 Standing on the Shoulders of Giants

- PowerShell profile inspired by [Chris Titus Tech](https://github.com/ChrisTitusTech/powershell-profile) (the GOAT)
- WindHawk mods from the [WindHawk community](https://windhawk.net/) (doing God's work)
- Starship prompt from [starship.rs](https://starship.rs/) (Rust supremacy)
- Zoxide from [ajeetdsouza](https://github.com/ajeetdsouza/zoxide) (cd but better)

---

<div align="center">

**⚡ Crafted with caffeine and spite for Windows defaults ⚡**

*"It's not about the destination, it's about optimizing the journey"*

**Star this if it saved you from Windows hell** ⭐

</div>
