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

## SSH alias
alias sshpi="ssh pi@raspberrypi"
