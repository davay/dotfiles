# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="fletcherm"

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
alias vimc="vim ~/.config/lvim/config.lua"
alias zshc="vim ~/.zshrc"
alias skhdc="vim ~/.config/skhd/skhdrc"
alias yabaic="vim ~/.config/yabai/yabairc"
alias yadmc="vim ~/.config/yadm/bootstrap"
alias linuxc="vim ~/.config/yadm/linux-install.yml"
alias kittyc="vim ~/.config/kitty/kitty.conf"
alias macc="vim ~/.config/yadm/mac-install.yml"
alias cdyadm="cd ~/.config/yadm/"
alias cdwork="cd ~/Work/repos/"
alias cdrepos="cd ~/Repos/"
alias neofetch="neofetch"
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

c() {
  cd "${@}" && ls | gsed '  
        # on line 8, print the line,
        8 {
            # append an ellipsis
            a[...]
            # and quit
            q
        }
        # print lines 1-4 verbatim
        '
}

# Pywal
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
export PATH=$PATH:/Users/davay/.spicetify
