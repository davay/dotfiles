# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="darkblood"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

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

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

