# Description

A [yadm](https://yadm.io/) + [Ansible](https://docs.ansible.com/ansible/latest/user_guide/index.html#getting-started) instant setup for fresh OS installs

NOTE: Main branch is brand new -- Mac only for now. Old combined Linux + Mac setup is in archive branch. No longer using Yabai, Stage Manager is quite nice. 

## Installation

### 1. Install Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. yadm + Ansible

```
brew install yadm && yadm clone https://github.com/davay/dotfiles.git && yadm bootstrap
```
