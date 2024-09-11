window_title=(
  script="$PLUGIN_DIR/window_title.sh"
  icon.drawing=off
)

sketchybar --add event title_change window_focus \
  --add item window_title left \
  --set window_title "${window_title[@]}" \
  --subscribe window_title window_focus front_app_switched space_change title_change
