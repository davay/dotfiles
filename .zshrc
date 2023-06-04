eval $(thefuck --alias)

# General alias
alias sudo="sudo " # enable aliases for sudo
alias tf="fuck"
alias vim="nvim"
alias pack="tar -zcvf"
alias unpack="tar -zxvf"
alias exrdeploy="(cdexr && pack editxr.tgz --exclude=node_modules --exclude=dist --exclude=editxr.tgz * && gcloud builds submit editxr.tgz)"
alias ls="gls --color" # colorful GNU ls 

# Config alias
alias zshc="vim ~/.zshrc"
alias yadmc="vim ~/.config/yadm/bootstrap"
alias macc="vim ~/.config/yadm/mac-install.yml"

# cd alias
alias cdyadm="cd ~/.config/yadm/"
alias cdexr="cd ~/Repos/Personal/EditXR/"
alias cdrepos="cd ~/Repos/"
alias cdwork="cd ~/Repos/Work/"
alias cdmangas="cd ~/Mangas/"

# SSH alias
alias sshpi="ssh pi@raspberrypi"

# git alias
alias backmerge="currBranch=\$(git rev-parse --abbrev-ref HEAD) && git checkout dev && git pull && git checkout \$currBranch && git merge dev"
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
