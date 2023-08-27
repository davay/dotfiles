battery=(
  script="$PLUGIN_DIR/battery.sh"
  update_freq=120
  label.padding_left=0
  label.padding_right=0
)

sketchybar --add event battery_update \
           --add item battery right \
           --set battery "${battery[@]}" \
           --subscribe battery battery_update power_source_change system_woke