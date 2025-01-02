# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
  vi-mode
  ) # this one doesnt conflict with autosuggestions, somehow the tab completion wont work with the other one
source $HOME/.oh-my-zsh/oh-my-zsh.sh

# Custom plugins installed using brew or smth
BREW=$(brew --prefix)

# WARNING: BREAKS MOLTEN'S WEZTERM IMAGE OUTPUT -- the highlighting is a color code like ;12;23
# source $BREW/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Portable config; goes after oh-my-zsh so it overrides
source ~/.zshrc_portable

# Local config; splitting it so dotfile copying is easy
source ~/.zshrc_local
