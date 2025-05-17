plugins=(
  vi-mode
  ) # this one doesnt conflict with autosuggestions, somehow the tab completion wont work with the other one
source $HOME/.oh-my-zsh/oh-my-zsh.sh

# Portable config; goes after oh-my-zsh so it overrides
source ~/.zshrc_portable

# Local config; splitting it so dotfile copying is easy
# Won't exist on servers
[[ ! -f ~/.zshrc_local ]] || source ~/.zshrc_local

autoload -U +X bashcompinit && bashcompinit
