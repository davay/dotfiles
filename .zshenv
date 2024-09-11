# sourced on all invocations of shell, even non-interactive ones
# using this for SKHD
# .zshrc is only sourced in interactive shells, so it didn't work

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
