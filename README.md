# Poof setup into existence

A [yadm](https://yadm.io/) + [Ansible](https://docs.ansible.com/ansible/latest/user_guide/index.html#getting-started) instant setup for fresh OS installs
 
## Installation

### Manjaro / Arch
```sudo pacman -S --noconfirm yay && yay -S --noconfirm yadm-git && yes | yadm clone https://github.com/davay/dotfiles.git```

### Mac

#### [Disable SIP (for Yabai)](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection)

#### Install Brew
``` 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/davay/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### yadm + Ansible
```
brew install yadm && yadm clone https://github.com/davay/dotfiles.git && yadm bootstrap
```
