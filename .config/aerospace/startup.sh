#!/bin/bash

# Check if built-in display is active
if system_profiler SPDisplaysDataType | grep -q "Built-in"; then
    # Built-in monitor == horizontal tiling
    aerospace workspace F1 && aerospace layout h_tiles
    aerospace workspace F2 && aerospace layout h_tiles  
    aerospace workspace F3 && aerospace layout h_tiles
    aerospace workspace-back-and-forth  # Return to previous workspace
else
    # Secondary monitor == vertical tiling
    aerospace workspace F1 && aerospace layout v_tiles
    aerospace workspace F2 && aerospace layout v_tiles
    aerospace workspace F3 && aerospace layout v_tiles
    aerospace workspace-back-and-forth
fi

# Start sketchybar after aerospace so workspaces show up properly

sketchybar
