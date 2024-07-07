#!/bin/bash

waybar_config="$HOME/.config/waybar/config"
waybar_style="$HOME/.config/waybar/style.css"
waybar_style_color="$HOME/.config/waybar/mocha.css"

# Check if the process is running
if pgrep -x "waybar" >/dev/null; then
  echo "Process is running, killing it..."
  pkill -f "waybar"
  echo "Process killed."
else
  echo "Process is not running, starting it..."
  # Command to start your process
  waybar -c $waybar_config -s $waybar_style &
  -s $waybar_style_color &
  -s $waybar_style
  echo "Process started."
fi
