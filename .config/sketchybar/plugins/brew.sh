COUNT=$(brew outdated | wc -l | tr -d ' ')

sketchybar --set $NAME label="$COUNT"