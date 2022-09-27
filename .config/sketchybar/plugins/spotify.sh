#!/usr/bin/env sh

RUNNING=$(osascript -e 'if application "Spotify" is running then return 1')
if [ "$RUNNING" == "" ]; then
  RUNNING=0
fi
PLAYING=0
TRACK=""
ALBUM=""
ARTIST=""
if [ "$(osascript -e 'if application "Spotify" is running then tell application "Spotify" to get player state')" == "playing" ]; then
  PLAYING=1
  TRACK=$(osascript -e 'tell application "Spotify" to get name of current track')
  ARTIST=$(osascript -e 'tell application "Spotify" to get artist of current track')
  ALBUM=$(osascript -e 'tell application "Spotify" to get album of current track')
fi
if [ $RUNNING -eq 1 ] && [ $PLAYING -eq 1 ]; then
  if [ "$ARTIST" == "" ]; then
    sketchybar --set $NAME label="$TRACK - $ALBUM" --set '/spot.*/' drawing=on
  else
    sketchybar --set $NAME label=" $TRACK -  $ARTIST" --set '/spot.*/' drawing=on
  fi
# else
#   sketchybar --set '/spot.*/' drawing=off
fi
