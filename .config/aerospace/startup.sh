#!/bin/bash

# Check if built-in display is active
if system_profiler SPDisplaysDataType | grep -q "Built-in"; then
    # Set horizontal layout for F workspaces on built-in monitor
    aerospace workspace F1 && aerospace layout h_tiles
    aerospace workspace F2 && aerospace layout h_tiles  
    aerospace workspace F3 && aerospace layout h_tiles
    aerospace workspace-back-and-forth  # Return to previous workspace
else
    # Set vertical layout for F workspaces on secondary monitor
    aerospace workspace F1 && aerospace layout v_tiles
    aerospace workspace F2 && aerospace layout v_tiles
    aerospace workspace F3 && aerospace layout v_tiles
    aerospace workspace-back-and-forth
fi