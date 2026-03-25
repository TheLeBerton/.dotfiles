#!/bin/bash

WAYBAR_CONF=$HOME/.config/waybar

source $HOME/.cache/wal/colors.sh

waybar_style=$1
nvim_theme=$2

active="${color4#\#}"
inactive="${color0#\#}"

hyprctl keyword general:col.active_border "rgba(${active}ee)"
hyprctl keyword general:col.inactive_border "rgba(${inactive}44)"

pkill waybar
waybar -c $WAYBAR_CONF/config.json -s $WAYBAR_CONF/$waybar_style &

pkill mako
swaync-client --reload-css &

echo "$nvim_theme" > "$HOME/.cache/wal/nvim-theme"
