#!/bin/bash

if [ -z $1 ]; then
    #xrandr --verbose | grep Brightness:
    xrandr --verbose | grep -E "(Gam.+|Brightness.+)"
else
    xrandr --output LVDS1 --brightness $1
fi

