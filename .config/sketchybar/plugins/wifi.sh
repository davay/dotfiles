source "$CONFIG_DIR/colors.sh"

# Check if wifi is connected by looking for an SSID in the network info
WIFI_INTERFACE=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $NF}')
WIFI_STATUS=$(ipconfig getsummary "$WIFI_INTERFACE" 2>/dev/null | grep '  SSID : ')

if [ -n "$WIFI_STATUS" ]; then
  # Connected
  sketchybar --set $NAME icon.color=$ICON_COLOR label.drawing=off
else
  # Disconnected
  sketchybar --set $NAME icon.color=$GREY label.drawing=off
fi
