WINDOW_TITLE=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.title')
WINDOW_APP=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.app')

if [[ $WINDOW_APP = "" ]]; then
  DISPLAY_TEXT="$WINDOW_TITLE"
else
  DISPLAY_TEXT="$WINDOW_APP | $WINDOW_TITLE"
fi

if [[ ${#DISPLAY_TEXT} -gt 50 ]]; then
  DISPLAY_TEXT=$(echo "$DISPLAY_TEXT" | cut -c 1-55)
  sketchybar -m --set window_title label="$DISPLAY_TEXT"…
  exit 0
fi

sketchybar -m --set window_title label="$DISPLAY_TEXT"
