# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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

# Fix ssh backspace issue with kitty
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

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
        # print lines 1-8 verbatim
        '
}

# Pywal
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
export PATH=$PATH:/Users/davay/.spicetify

# OS specific alias
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

## Global alias ##
alias theme="kitty +kitten themes"
alias emoji="kitty +kitten choose"
alias sudo="sudo " # enable aliases for sudo
alias tf="fuck"
alias serve="browser-sync start --server --files ."
#alias vim="lvim"
#alias vimc="vim ~/.config/lvim/config.lua"
alias vim="nvim"
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
alias cdexr="cd ~/Repos/EditXR/"
alias neofetch="neofetch"
alias spotifytheme="spicetify config current_theme"
alias spotifycolor="spicetify config color_scheme"
alias 😀="sl"
alias python="python3" 
alias pack="tar -zcvf"
alias unpack="tar -zxvf"
alias exrdeploy="(cdexr && pack editxr.tgz --exclude=node_modules --exclude=dist --exclude=editxr.tgz * && gcloud builds submit editxr.tgz)"
alias sshpi="ssh pi@raspberrypi"
alias spacebarc="vim ~/.config/spacebar/spacebarrc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
