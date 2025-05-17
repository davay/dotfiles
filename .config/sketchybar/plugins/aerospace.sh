source "$CONFIG_DIR/colors.sh" # have to define it here too, items get imported into main sketchybarrc but not this

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.border_color=$BAR_BORDER_COLOR
else
    sketchybar --set $NAME background.border_color=$PRIMARY_1
fi
