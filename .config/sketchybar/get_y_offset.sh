#!/bin/sh

count=$(system_profiler SPDisplaysDataType | grep -c Resolution)
airplay=$(system_profiler SPDisplaysDataType | grep -c AirPlay)

if [[ $count -eq 3 ]] || ([[ $count -eq 2 ]] && [[ $airplay -eq 0 ]]); then
  echo "-25"
else 
  echo "-38"
fi
