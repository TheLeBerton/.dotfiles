#!/bin/bash

value=$(( $(brightnessctl g) * 100 / $(brightnessctl m) ))
if [ "$value" -lt 35 ]; then
    icon="○"
elif [ "$value" -lt 75 ]; then
    icon="◑"
else
    icon="●"
fi

echo "$icon $value%"
