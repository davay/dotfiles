sketchybar --add space space_template left \
    --set space_template label.drawing=off \
    drawing=off \
    updates=on \
    script="$PLUGIN_DIR/space.sh" \
    click_script="$PLUGIN_DIR/space_click.sh" \
    --subscribe space space_change \
    \
    --clone space_1 space_template \
    --set space_1 associated_space=1 drawing=on \
    \
    --clone space_2 space_template \
    --set space_2 associated_space=2 drawing=on \
    \
    --clone space_3 space_template \
    --set space_3 associated_space=3 drawing=on \
    \
    --clone space_4 space_template \
    --set space_4 associated_space=4 drawing=on \
    \
    --clone space_5 space_template \
    --set space_5 associated_space=5 drawing=on \
    \
    --clone space_6 space_template \
    --set space_6 associated_space=6 drawing=on \
    \
    --clone space_7 space_template \
    --set space_7 associated_space=7 drawing=on \
    \
    --clone space_8 space_template \
    --set space_8 associated_space=8 drawing=on \
    \
    --clone space_9 space_template \
    --set space_9 associated_space=9 drawing=on \

