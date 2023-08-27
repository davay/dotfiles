source "$CONFIG_DIR/colors.sh"

args=()
if [ "$NAME" != "space_template" ]; then
  args+=(--set $NAME label=$NAME
    icon=
    icon.y_offset=0
  )
fi

if [ "$SELECTED" = "true" ]; then
  args+=(--set spaces_$DID.label label=${NAME#"spaces_$DID"})
  args+=(--set $NAME icon=)
else
  args+=(--set $NAME)
fi

sketchybar -m --animate tanh 20 "${args[@]}"