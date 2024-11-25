#!/usr/bin/env sh

# This script is executed when either the mode changes,
# or the commandline changes
# This is just an example using sketchybar:
# The variables $MODE and $CMDLINE hold the 
# current editor and cmdline info
#
# Remaining config in sketchybar

COLOR=0xff9dd274
if [ "$MODE" = "" ]; then
  COLOR=0xffff6578
fi

DRAW_CMD="off"
if [ "$CMDLINE" != "" ]; then
  DRAW_CMD="on"
fi

sketchybar --set svim.mode label="[$MODE]" \
                           label.drawing=$(if [ "$MODE" = "" ]; then echo "off"; else echo "on"; fi) \
                           icon.color=$COLOR \
                           popup.drawing=$DRAW_CMD \
           --set svim.cmdline label="$CMDLINE"
