# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="darkblood"

zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

plugins=(zsh-nvm git)

source $ZSH/oh-my-zsh.sh

## Global ##

alias theme="kitty +kitten themes"
alias emoji="kitty +kitten choose"
alias vim="lvim"
alias sudo="sudo " # enable aliases for sudo
alias tf="fuck"
alias serve="browser-sync start --server --files ."
alias vimconfig="vim ~/.config/lvim/config.lua"
alias zshconfig="vim ~/.zshrc"
alias skhdconfig="vim ~/.config/skhd/skhdrc"
alias yabaiconfig="vim ~/.config/yabai/yabairc"
alias yadmconfig="vim ~/.config/yadm/bootstrap"
alias linuxconfig="vim ~/.config/yadm/linux-install.yml"
alias kittyconfig="vim ~/.config/kitty/kitty.conf"
alias macconfig="vim ~/.config/yadm/mac-install.yml"
alias cdyadm="cd ~/.config/yadm/"
alias neofetch="neofetch | lolcat"
alias spotifytheme="spicetify config current_theme"
alias spotifycolor="spicetify config color_scheme"
alias 😀="sl"
alias python="python3" 

case `uname` in
	Linux)
		alias i3config="vim ~/.i3/config"
		alias theme="wpg -s \$(wpg -l | fzf) && wal -R && pywal-discord"
		alias addtheme="wpg -a "
		cat ~/.cache/wal/sequences # fix for kitty color resetting on new window
		ZSH_DISABLE_COMPFIX=true
		unsetopt PROMPT_SP	
	;;
	Darwin)
		alias ls="gls --color"
	;;
esac

eval $(thefuck --alias)

# Swap Caps Lock <-> Escape
# BAD HACK, runs everytime terminal is opened. Pushed to /dev/null to remove output messages. 
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039, "HIDKeyboardModifierMappingDst":0x700000029},{"HIDKeyboardModifierMappingSrc":0x700000029,"HIDKeyboardModifierMappingDst":0x700000039}]}' > /dev/null 2>&1 

# Lunarvim
export PATH="$(pwd)/.local/bin:$PATH"
export EDITOR='lvim'

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
