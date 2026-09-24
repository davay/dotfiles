#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Screen Record
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Records a 15 second video
screencapture -V 15 -k ~/Desktop/"$(date +'%F_%H%M%S').mov" &

