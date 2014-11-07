#!/bin/bash

# Simple script to show the battery status for OS X
# or the hostname when on another platform
if [ "$(uname)" == "Darwin" ];then
    echo "($(pmset -g batt | grep -o -E '[0-9]+%'))"
else 
    echo "\"$(hostname)\""
fi
