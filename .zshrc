# Random stuff
eval $(thefuck --alias)
export PATH=$PATH:~/.cargo/bin/

# General alias
alias sudo="sudo " # enable aliases for sudo
alias tf="fuck"
alias vim="nvim"
alias pack="tar -zcvf"
alias unpack="tar -zxvf"
alias exrdeploy="(cdexr && pack editxr.tgz --exclude=node_modules --exclude=dist --exclude=editxr.tgz * && gcloud builds submit editxr.tgz)"
alias ls="gls --color" # colorful GNU ls 
alias r="radian"
alias router="netstat -nr|grep default" # router ip addr

# Config alias
alias zshc="vim ~/.zshrc"
alias yadmc="vim ~/.config/yadm/bootstrap"
alias macc="vim ~/.config/yadm/mac-install.yml"
alias yabaic="vim ~/.config/yabai/yabairc"
alias skhdc="vim ~/.config/skhd/skhdrc"
alias sketchybarc="vim ~/.config/sketchybar/sketchybarrc"

# cd alias
alias cdconfig="cd ~/.config"
alias cdyadm="cd ~/.config/yadm/"
alias cdexr="cd ~/Repos/Personal/EditXR/"
alias cdrepos="cd ~/Repos/"
alias cdwork="cd ~/Repos/Work/"
alias cdschool="cd ~/Repos/School/"
alias cdmangas="cd ~/Mangas/"

# SSH alias
alias sshpi="ssh pi@raspberrypi"
#alias sshda="ssh davay@$(ping -c 1 da | grep PING | sed 's/.*(\(.*\)).*/\1/')"
alias sshda="ssh davay@ssh.devinl.im"

# git alias
alias backmerge="currBranch=\$(git rev-parse --abbrev-ref HEAD) && git checkout develop && git pull && git checkout \$currBranch && git merge develop"
alias clean="git reset --hard && git clean -dfx"
alias upstream="currBranch=\$(git rev-parse --abbrev-ref HEAD) && git push --set-upstream origin \$currBranch"

# Custom functions
 timezsh() {
   shell=${1-$SHELL}
   for i in $(seq 1 10); do 
    /usr/bin/time $shell -i -c exit;
   done
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

rmManga() {
	 /Users/davay/.config/yadm/rmManga.exp | osascript -e 'tell application "System Events" to keystroke "5fZfFaqnVx" using {control down, shift down}' 
}

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
