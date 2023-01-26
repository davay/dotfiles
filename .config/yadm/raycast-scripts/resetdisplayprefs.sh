#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reset Display Preferences
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description https://forums.macrumors.com/threads/external-displays-swapping-arrangement-not-remembered.2320211/page-6

if [[ $EUID -ne 0 ]]; then
 echo "Please run this script as root"
 exit 1
fi

errors_occured=false
file_list=$(mktemp)
trap 'rm $file_list' EXIT

find "/Library/Preferences" -name "com.apple.windowserver.plist*" 2>/dev/null > "$file_list"
find "/Library/Preferences" -name "com.apple.windowserver.displays.plist*" 2>/dev/null >> "$file_list"

for i in ~root /Users/*; do
    find "$i/Library/Preferences/ByHost" -name "com.apple.windowserver.*.plist*" 2>/dev/null >> "$file_list"
done

if [[ $(wc -l < "$file_list") -eq 0 ]]; then
    echo "No display preferences found, terminating script"
    [[ "$0" = "${BASH_SOURCE[0]}" ]] && exit 1
fi

echo "This script will delete following files:"
cat "$file_list"

read -p "Do you want to proceed? [Y/N] " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Display preferences has not been reset, terminating script"
    [[ "$0" = "${BASH_SOURCE[0]}" ]] && exit 1
fi

echo "Deleting files..."
while read -r file; do
    echo -n "[delete] : $file"
    if rm -f "$file" 2>/dev/null
    then
        echo " - done"
    else
        errors_occured=true
        echo " - ERROR"
    fi
done < "$file_list"

if [ "$errors_occured" = false ]; then
    echo "All done! Please restart the system"
else
    echo "Errors occurred"
fi
