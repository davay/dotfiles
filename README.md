# Description

A [yadm](https://yadm.io/) + [Ansible](https://docs.ansible.com/ansible/latest/user_guide/index.html#getting-started) instant setup for fresh OS installs

## Installation

### Manjaro / Arch

```
sudo pacman -S --noconfirm yay && yay -S --noconfirm yadm-git && yes | yadm clone https://github.com/davay/dotfiles.git
```

### Mac (Apple Silicon)

#### 1. (OPTIONAL) Disable SIP [Yabai docs](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection)

Boot into recovery mode: Press and hold the `power` button on your Mac until “Loading startup options” appears.

Click Options, then click Continue.

In the topbar, choose `Utilities`, then `Terminal`

```
csrutil disable --with kext --with dtrace --with basesystem
```

#### 2. Install Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### 3. yadm + Ansible

```
brew install yadm && yadm clone https://github.com/davay/dotfiles.git && yadm bootstrap
```
