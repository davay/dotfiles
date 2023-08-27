music=(
    script="$PLUGIN_DIR/music.sh"
    click_script="$PLUGIN_DIR/music_click.sh"
    updates=on
    icon.drawing=off
    label.drawing=off
)

sketchybar --add item music left \
    --set music "${music[@]}" \
    --subscribe music media_change