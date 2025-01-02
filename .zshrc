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

# Portable config; goes after oh-my-zsh so it overrides
source ~/.zshrc_portable

# Local config; splitting it so dotfile copying is easy
# Won't exist on servers
[[ ! -f ~/.zshrc_local ]] || source ~/.zshrc_local
