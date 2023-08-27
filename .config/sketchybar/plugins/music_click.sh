# run an osascript command to get the player_state
PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")

if [[ $PLAYER_STATE == "paused" ]]; then
  osascript -e 'tell application "Music" to play'
else
  osascript -e 'tell application "Music" to pause'
fi