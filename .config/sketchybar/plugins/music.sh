STATE="$(echo "$INFO" | jq -r '.state')"
TITLE="$(echo "$INFO" | jq -r '.title')"
ARTIST="$(echo "$INFO" | jq -r '.artist')"

if [[ -n "$TITLE" && -n "$ARTIST" ]]; then
    sketchybar --set $NAME label="$TITLE - $ARTIST" label.drawing=on
elif [[ -n "$TITLE" ]]; then
    sketchybar --set $NAME label="$TITLE" label.drawing=on
fi
