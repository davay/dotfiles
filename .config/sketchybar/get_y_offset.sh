#!/bin/sh

count=$(system_profiler SPDisplaysDataType | grep -c Resolution)
airplay=$(system_profiler SPDisplaysDataType | grep -c AirPlay)

if [[ $count -eq 3 ]] || ([[ $count -eq 2 ]] && [[ $airplay -eq 0 ]]); then
  # echo "-25" # 2026-07-25: they fixed this -- at least on external monitors
  echo "0"
else
  echo "-32" # this one however is not fixed, but i did have to change the value from 38 -> 32
fi
