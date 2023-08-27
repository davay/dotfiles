STATE="$(echo "$INFO" | jq -r '.state')"
MEDIA="$(echo "$INFO" | jq -r '.title + " - " + .artist')"

if [[ -n "$MEDIA" ]]; then
    sketchybar --set $NAME label="$MEDIA" label.drawing=on
fi