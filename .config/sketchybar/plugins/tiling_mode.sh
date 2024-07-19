MODE=$(yabai -m query --spaces --space | jq -r '.type')
sketchybar --set $NAME icon="􀧍" label="$MODE"
