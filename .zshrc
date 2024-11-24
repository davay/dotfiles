# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zshrc_portable

# General alias
alias router="netstat -nr|grep default" # router ip addr
alias leetcode="nvim leetcode.nvim"
alias exrdeploy="(cexr && pack editxr.tgz --exclude=node_modules --exclude=dist --exclude=editxr.tgz * && gcloud builds submit editxr.tgz)"
alias man="batman"
alias less="batpipe"
alias watch="batwatch"
alias diff="batdiff"
alias rg="batgrep"

# Config alias
alias yadmc="vim ~/.config/yadm/bootstrap"
alias macc="vim ~/.config/yadm/mac-install.yml"
alias yabaic="vim ~/.config/yabai/yabairc"
alias skhdc="vim ~/.config/skhd/skhdrc"
alias sketchybarc="vim ~/.config/sketchybar/sketchybarrc"
alias wezc="vim ~/.wezterm.lua"
alias zshpc="vim ~/.zshrc_portable"

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
conda activate py311

# Created by `pipx` on 2024-06-02 07:59:19
export PATH="$PATH:/Users/davay/.local/bin"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$(gem environment gemdir)/bin:$PATH"

# for image.nvim
export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

# powerlevel10k
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
