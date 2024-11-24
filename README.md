# Description

A [yadm](https://yadm.io/) + [Ansible](https://docs.ansible.com/ansible/latest/user_guide/index.html#getting-started) instant setup for fresh OS installs. 

NOTE: Main branch is brand new -- Mac only for now. Old combined Linux + Mac setup is in archive branch. Yabai, skhd, and sketchybar are all preinstalled along with configs, but manual setup is required, instructions not here. Config for SIP-enabled yabai is in yabai.bak + skhd.bak. Otherwise, the configs present are for non-SIP yabai (mostly to focus display)

## Screenshot 

![Worfklow Example](/.config/yadm/dotfiles.png)

## Installation

### 1. Install Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile && eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. yadm + Ansible

```
brew install yadm && yadm clone https://github.com/davay/dotfiles.git
```

### 3. Manual Steps

- Rectangle Pro: Select "Sync configuration over iCloud"

- Finder: Select "Sync Desktop & Documents folders"

- Google Drive: Select "Mirror Files"

- Settings - Keyboard: Unselect all keyboard shortcuts

- Raycast: Import config

- Shottr: Input License, set hotkey

- Backblaze: Inherit backup state

- Warp: Theme, font, and quake mode (30%w, 80%h)

- 1Password: Enable SSH agent, set hotkey

- Calendar: Add accounts

- Settings - Touch ID & Password: Change password (iykyk) and use Apple Watch to unlock

- Settings - Privacy & Security: Allow apps from anywhere

- Yabai + Skhd: Start Service

- Skim: Set headless config to sync with nvim https://github.com/benbrastmckie/.config
