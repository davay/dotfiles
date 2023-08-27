volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.background.height=5
  slider.background.corner_radius=3
  slider.knob=􀀁
  slider.knob.drawing=off
  slider.knob.y_offset=0
  slider.padding_right=0
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  label.drawing=off
  icon=$VOLUME_100
)

sketchybar --add slider volume right \
  --set volume "${volume_slider[@]}" \
  --subscribe volume \
  volume_change \
  mouse.clicked \
  mouse.entered \
  mouse.exited \
  --add item volume_icon right \
  --set volume_icon "${volume_icon[@]}"
