cava=(
    script="$PLUGIN_DIR/cava.sh"
    click_script="$PLUGIN_DIR/music_click.sh"
    update_freq=0
    icon.drawing=off
)

sketchybar --add item cava left \
    --set cava "${cava[@]}"
