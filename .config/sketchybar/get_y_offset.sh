#!/bin/sh

count=$(system_profiler SPDisplaysDataType | grep -c Resolution)
airplay=$(system_profiler SPDisplaysDataType | grep -c AirPlay)

if [[ $count -eq 2 ]] && [[ $airplay -eq 0 ]]; then
  echo "-24"
else 
  echo "-38"
fi
