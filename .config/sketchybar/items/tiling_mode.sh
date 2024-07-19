tiling_mode=(
  script="$PLUGIN_DIR/tiling_mode.sh"
)

sketchybar --add event tiling_mode_update \
  --add item tiling_mode right \
  --set tiling_mode "${tiling_mode[@]}" \
  --subscribe tiling_mode tiling_mode_update
