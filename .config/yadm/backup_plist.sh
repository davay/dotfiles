#!/bin/bash

# Directory containing plist files
PLIST_DIR="$HOME/.config/yadm/plist"

for plist in "$PLIST_DIR"/*.plist; do
    if [ -f "$plist" ]; then
        filename=$(basename "$plist")
        domain="${filename%.*}"

        # Compare the temporary file with the existing plist
        temp_plist=$(mktemp)
        defaults export "$domain" "$temp_plist"
        if ! cmp -s "$temp_plist" "$plist"; then
            # If different, update the existing plist
            mv "$temp_plist" "$plist"
            echo "Updated $plist"
        else
            # If the same, remove the temporary file
            rm "$temp_plist"
            echo "No changes for $plist"
        fi
    fi
done
