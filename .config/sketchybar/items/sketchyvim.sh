svim_mode=(
    popup.align=right \
    icon= \
    icon.font="Hack Nerd Font Mono:Bold:28.0" \
    label.font="Hack Nerd Font Mono:Bold:13.0" \
    icon.color=0xffff6578 \
    script="$PLUGIN_DIR/sketchyvim.sh"
)

sketchybar --add item svim.mode right \
           --set svim.mode "${svim_mode[@]}" \
           --subscribe svim.mode front_app_switched window_focus \
           --add item svim.cmdline
