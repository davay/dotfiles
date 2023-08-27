brew=(
  icon=􀐛
  label="?"
  script="$PLUGIN_DIR/brew.sh"
)

sketchybar --add event brew_update \
  --add item brew right \
  --set brew "${brew[@]}" \
  --subscribe brew brew_update
