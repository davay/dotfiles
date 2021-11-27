# Poof setup into existence

A [yadm](https://yadm.io/) + [Ansible](https://docs.ansible.com/ansible/latest/user_guide/index.html#getting-started) instant setup for fresh OS installs
 
## Installation

### Manjaro / Arch
```sudo pacman --noconfirm -S yay && yay -S yadm-git && yes | yadm clone https://github.com/davay/dotfiles.git```

### Mac
```brew install yadm && yadm clone https://github.com/davay/dotfiles.git && yadm bootstrap```

## TODO
- mac specific setup -- remember to split .zshrc, see dotfiles_archive
