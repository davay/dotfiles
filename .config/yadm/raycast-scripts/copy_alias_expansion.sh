#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Alias Expansion
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "alias name" }

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Looks up a fish alias and copies its expansion to clipboard
/opt/homebrew/bin/fish -c "alias" | grep "^alias $1 " | sed "s/^alias $1 //" | tr -d "'\n" | pbcopy
