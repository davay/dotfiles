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

# Portable aliases; goes after oh-my-zsh so it overrides
source ~/.zshrc_portable

# General alias
alias router="netstat -nr|grep default" # router ip addr
alias leetcode="nvim leetcode.nvim"
alias exrdeploy="(cexr && pack editxr.tgz --exclude=node_modules --exclude=dist --exclude=editxr.tgz * && gcloud builds submit editxr.tgz)"
alias man="batman"
alias less="batpipe"
alias watch="batwatch"
alias diff="batdiff --staged"
alias rg="batgrep"
alias skim="/Applications/Skim.app/Contents/MacOS/Skim"
present() {
    jupyter dejavu "$1" --template reveal
    open "${1%.*}.html"
}
alias ard="arduino-cli"
mov2mp4() {
    avconvert --source "$1" --output "${1%.*}.mp4" --preset PresetHighestQuality
}
vidstack() {
    if [ "$1" = "--audio" ]; then
        ffmpeg -i "$2" -i "$3" -filter_complex "[0:v][1:v]hstack=inputs=2[v]" -map "[v]" -map "0:a" stacked.mp4
    else
        ffmpeg -i "$1" -i "$2" -filter_complex "[0:v][1:v]hstack=inputs=2[v]" -map "[v]" stacked.mp4
    fi
}

# Config alias
alias yadmc="vim ~/.config/yadm/bootstrap"
alias macc="vim ~/.config/yadm/mac-install.yml"
alias yabaic="vim ~/.config/yabai/yabairc"
alias skhdc="vim ~/.config/skhd/skhdrc"
alias sketchybarc="vim ~/.config/sketchybar/sketchybarrc"
alias wezc="vim ~/.wezterm.lua"
alias zshpc="vim ~/.zshrc_portable"
alias kittyc="vim ~/.config/kitty/kitty.conf"
alias ghosttyc="vim ~/Library/Application\ Support/com.mitchellh.ghostty/config"

# cd alias 
alias cyadm="c ~/.config/yadm"
alias csketchybar="c ~/.config/sketchybar/"
alias cexr="c ~/Repos/Personal/EditXR"
alias crepos="c ~/Repos"
alias cwork="c ~/Repos/Work"
alias cschool="c ~/Repos/School"
alias cpersonal="c ~/Repos/Personal"
alias csu="c ~/Drive/usa/school/su"
alias cleetcode="c ~/Repos/Personal/leetcode"

# yadm alias 
alias ycommit="yadm commit -am"
alias ystatus="yadm status"
alias ydiff="yadm diff | prettybat"
alias yadd="yadm add"
alias ypull="yadm pull"
alias ypush="yadm push"
alias yclean="yadm clean -dfx"
alias yreset="yadm reset --hard HEAD"
alias ynuke="yadm clean -dfx && yadm reset --hard HEAD"

# SSH alias
alias synchetzner="syncssh root@hetzner.devinl.im"

# custom scripts 
alias colortest="~/.config/yadm/scripts/colortest.sh"
alias syncssh="~/.config/yadm/scripts/sync_ssh.sh"

# python pacakges required for jupyter
alias condavimdeps="conda install pynvim jupyter_client jupytext ipython ipykernel"
alias condadsdeps="conda install numpy matplotlib scikit-learn pandas pytorch"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda activate py312

export PATH="$PATH:/Users/davay/.local/bin"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$(gem environment gemdir)/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# for image.nvim
export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

# powerlevel10k
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # plugin customizations
source $BREW/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
bindkey "$terminfo[kcbt]" menu-select
bindkey -M menuselect '^I' menu-complete
bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete

source $BREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_HISTORY_IGNORE='(cd|ls|vim|c|l|v) *' # prevent invalid suggestions

# New widget; prioritize autosuggest, otherwise use first item in menu
_custom_tab_accept_suggestion() {
    if [[ -n "$POSTDISPLAY" ]]; then
        zle autosuggest-accept
    else
        zle menu-select
    fi
}
zle -N _custom_tab_accept_suggestion
bindkey '^I' _custom_tab_accept_suggestion # tab
