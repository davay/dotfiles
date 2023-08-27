datetime=(
  script="$PLUGIN_DIR/datetime.sh"
  icon.drawing=off
  update_freq=30
)

sketchybar --add item datetime right \
  --set datetime "${datetime[@]}" \
  --subscribe datetime system_woke
