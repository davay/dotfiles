wifi=(
    script="$PLUGIN_DIR/wifi.sh"
    icon=􀙇
    label.padding_left=0
)

sketchybar --add item wifi right \
    --set wifi "${wifi[@]}" \
    --subscribe wifi wifi_change