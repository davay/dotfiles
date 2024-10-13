#!/bin/bash

for i in {0..15}; do
    printf "\e[48;5;%sm  %3d  \e[0m" $i $i
    [ ! $((($i + 1) % 8)) -eq 0 ] && printf " " || printf "\n"
done
