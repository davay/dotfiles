fish_add_path /opt/homebrew/bin
fish_add_path ~/.cargo/bin
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path ~/.config/yadm/path-scripts

# remove fish greeting
set fish_greeting

# Core replacements
alias ls="lsd"
alias vim="nvim"

# Single letter aliases/functions
function c
    cd $argv && ls
end
alias v="nvim"
alias l="ls"

# ls aliases
alias la="ls -a"
alias ll="ls -lt"
alias lt="ls --tree --depth 2"

# cd aliases
alias cconfig="c ~/.config"
alias ch="c ~"
alias cnvim="c ~/.config/nvim/lua"
alias cghostty="c ~/Library/Application\ Support/com.mitchellh.ghostty"
alias cyadm="c ~/.config/yadm"
alias csketchybar="c ~/.config/sketchybar"
alias cexr="c ~/Repos/Personal/EditXR"
alias crepos="c ~/Repos"
alias cwork="c ~/Repos/Work"
alias cschool="c ~/Repos/School"
alias cpersonal="c ~/Repos/Personal"
alias csu="c ~/Drive/usa/school/su"
alias cleetcode="c ~/Repos/Personal/leetcode"
alias cdownloads="c ~/Downloads"
alias cusa="c ~/Drive/usa/"
alias cmutagen="c ~/Mutagen"
alias caerospace="c ~/.config/aerospace"
alias cfish="c ~/.config/fish"

# Config aliases
alias yadmc="vim ~/.config/yadm/bootstrap"
alias macc="vim ~/.config/yadm/mac-install.yml"
alias yabaic="vim ~/.config/yabai/yabairc"
alias skhdc="vim ~/.config/skhd/skhdrc"
alias sketchybarc="vim ~/.config/sketchybar/sketchybarrc"
alias wezc="vim ~/.wezterm.lua"
alias kittyc="vim ~/.config/kitty/kitty.conf"
alias ghosttyc="vim ~/Library/Application\ Support/com.mitchellh.ghostty/config"
alias aerospacec="vim ~/.config/aerospace/aerospace.toml"
alias fishc="vim ~/.config/fish/config.fish"

# Misc aliases
alias leetcode="nvim leetcode.nvim"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
