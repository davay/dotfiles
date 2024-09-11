#!/bin/bash 

# helpers for skhd
# alternatively yabairc is a bash file, so i can just pair each function with an event and have skhd sent the event

get_last_space() {
  yabai -m query --displays --display | jq '.spaces[-1]' 
}

is_first_space() {
  yabai -m query --spaces --display | jq '.[0]."has-focus"'
}

is_last_space() {
  yabai -m query --spaces --display | jq '.[-1]."has-focus"'
}

get_layout() {
  yabai -m query --spaces --space | jq -r '.type'
}

# call the function passed as arg 
"$@"
