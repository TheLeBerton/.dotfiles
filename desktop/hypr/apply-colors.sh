#!/bin/bash

source $HOME/.cache/wal/colors.sh

active="${color4#\#}"
inactive="${color0#\#}"

hyprctl keyword general:col.active_border "rgba(${active}ee)"
hyprctl keyword general:col.inactive_border "rgba(${inactive}44)"

pkill waybar
waybar -c ~/.config/waybar/config.json &
