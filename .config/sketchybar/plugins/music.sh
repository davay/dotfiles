STATE="$(echo "$INFO" | jq -r '.state')"
TITLE="$(echo "$INFO" | jq -r '.title')"
ARTIST="$(echo "$INFO" | jq -r '.artist')"
MAX_LENGTH=80

if [[ -n "$TITLE" && -n "$ARTIST" ]]; then
    LABEL=$(echo "$TITLE - $ARTIST" | cut -c 1-$MAX_LENGTH)
    sketchybar --set $NAME label="$LABEL" label.drawing=on 
elif [[ -n "$TITLE" ]]; then
    LABEL=$(echo "$TITLE" | cut -c 1-$MAX_LENGTH)
    sketchybar --set $NAME label="$LABEL" label.drawing=on
else
    LABEL=$(
	osascript -e 'tell application "Music" 
    	set titleName to name of current track
    	set artistName to artist of current track
    	return titleName & " - " & artistName
	end tell')
	if [[ -n "$LABEL" ]]; then
	    sketchybar --set $NAME label="$LABEL" label.drawing=on
	fi
fi
