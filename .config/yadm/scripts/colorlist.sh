#!/bin/bash

# Terminal Color Scheme Extractor
# Displays terminal colors with their hex codes

echo "Terminal Color Scheme:"
echo "====================="

# Function to get RGB values for a color
get_color_rgb() {
  local color_num=$1
  local color_type=$2 # "fg" for foreground, "bg" for background

  # Send OSC sequence to query color
  if [ "$color_type" = "fg" ]; then
    printf "\033]10;?\033\\"
  elif [ "$color_type" = "bg" ]; then
    printf "\033]11;?\033\\"
  else
    printf "\033]4;${color_num};?\033\\"
  fi

  # Read response (this might not work in all terminals)
  # Alternative approach using xrdb or other methods may be needed
}

# Function to convert RGB to hex
rgb_to_hex() {
  printf "#%02x%02x%02x\n" $1 $2 $3
}

# Display standard 16 colors with names and samples
declare -a color_names=("Black" "Red" "Green" "Yellow" "Blue" "Magenta" "Cyan" "White"
  "Bright Black" "Bright Red" "Bright Green" "Bright Yellow"
  "Bright Blue" "Bright Magenta" "Bright Cyan" "Bright White")

echo -e "\nStandard Colors (0-15):"
echo "----------------------"

for i in {0..15}; do
  # Create color sample using background color
  printf "\033[48;5;${i}m    \033[0m "

  # Print color number and name
  printf "Color %2d: %-13s " $i "${color_names[$i]}"

  # For most terminals, we can try to extract hex using different methods
  # Method 1: Try to use terminal's OSC response (limited support)

  # Method 2: Common default color approximations
  case $i in
  0) hex="#000000" ;;  # Black
  1) hex="#800000" ;;  # Red
  2) hex="#008000" ;;  # Green
  3) hex="#808000" ;;  # Yellow
  4) hex="#000080" ;;  # Blue
  5) hex="#800080" ;;  # Magenta
  6) hex="#008080" ;;  # Cyan
  7) hex="#c0c0c0" ;;  # White
  8) hex="#808080" ;;  # Bright Black
  9) hex="#ff0000" ;;  # Bright Red
  10) hex="#00ff00" ;; # Bright Green
  11) hex="#ffff00" ;; # Bright Yellow
  12) hex="#0000ff" ;; # Bright Blue
  13) hex="#ff00ff" ;; # Bright Magenta
  14) hex="#00ffff" ;; # Bright Cyan
  15) hex="#ffffff" ;; # Bright White
  *) hex="#unknown" ;;
  esac

  echo "$hex"
done

echo -e "\nForeground/Background:"
echo "---------------------"
printf "\033[39m████\033[0m Default Foreground\n"
printf "\033[49m    \033[0m Default Background\n"

echo -e "\nNote: Hex codes shown are common defaults."
echo "For exact colors, your terminal may need specific querying methods."

# Alternative method using xrdb (if available and X11)
if command -v xrdb &>/dev/null && [ -n "$DISPLAY" ]; then
  echo -e "\nTrying to get actual colors from X resources:"
  echo "--------------------------------------------"

  xrdb_colors=(
    "*.foreground" "*.background"
    "*.color0" "*.color1" "*.color2" "*.color3"
    "*.color4" "*.color5" "*.color6" "*.color7"
    "*.color8" "*.color9" "*.color10" "*.color11"
    "*.color12" "*.color13" "*.color14" "*.color15"
  )

  for resource in "${xrdb_colors[@]}"; do
    color=$(xrdb -query | grep -i "^${resource}" | cut -f2)
    if [ -n "$color" ]; then
      printf "%-15s: %s\n" "$resource" "$color"
    fi
  done
fi

# Method for getting colors from terminal emulator config files
echo -e "\nTo get exact hex codes, check your terminal's config file:"
echo "--------------------------------------------------------"
echo "• Alacritty: ~/.config/alacritty/alacritty.yml"
echo "• Kitty: ~/.config/kitty/kitty.conf"
echo "• iTerm2: Preferences > Profiles > Colors"
echo "• GNOME Terminal: dconf dump /org/gnome/terminal/legacy/profiles:/"
echo "• Xfce Terminal: ~/.config/xfce4/terminal/terminalrc"

# Visual color test
echo -e "\nColor Test Pattern:"
echo "==================="
for i in {0..15}; do
  printf "\033[48;5;${i}m %2d \033[0m" $i
  if [ $(((i + 1) % 8)) -eq 0 ]; then
    echo
  fi
done
echo
