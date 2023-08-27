POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add item apple.logo left \
    --set apple.logo icon=$APPLE \
    label.drawing=off \
    click_script="$POPUP_CLICK_SCRIPT" \
    \
    --add item apple.prefs popup.apple.logo \
    --set apple.prefs icon=$PREFERENCES \
    icon.padding_right=20 \
    icon.padding_left=10 \
    label="Settings" \
    click_script="open -a 'System Preferences';$POPUP_OFF" \
    \
    --add item apple.activity popup.apple.logo \
    --set apple.activity icon=$ACTIVITY \
    icon.padding_right=20 \
    icon.padding_left=10 \
    label="Activity" \
    click_script="open -a 'Activity Monitor';$POPUP_OFF" \
    \
    --add item apple.lock popup.apple.logo \
    --set apple.lock icon=$LOCK \
    icon.padding_right=20 \
    icon.padding_left=10 \
    label.padding_right=20\
    label="Lock Screen" \
    click_script="pmset displaysleepnow;$POPUP_OFF"
