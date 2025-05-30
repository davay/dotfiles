sketchybar --add event aerospace_workspace_change


# trying to use brackets way, but WIP
# sketchybar --add aerospace aerospace_template left \
#   --set aerospace_template label.drawing=off \
#   script="$PLUGIN_DIR/aerospace.sh $sid" \
#   click_script="aerospace workspace $sid" \
#   --subscribe aerospace aerospace_workspace_change\


for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.drawing=on \
        background.color=$PRIMARY_1 \
        background.corner_radius=6 \
        background.border_width=2 \
        background.border_color=$PRIMARY_2 \
        background.height=24 \
        background.padding_right=10 \
        label="$sid" \
        label.padding_left=15 \
        label.padding_right=15 \
        icon.drawing=off \
        click_script="aerospace workspace $sid" \
        script="$PLUGIN_DIR/aerospace.sh $sid"
done
