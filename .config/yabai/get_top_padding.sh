#!/bin/sh

count=$(system_profiler SPDisplaysDataType | grep -c Resolution)

if [ $count -eq 1 ] ; then
  echo "0"
else 
  echo "12"
fi
