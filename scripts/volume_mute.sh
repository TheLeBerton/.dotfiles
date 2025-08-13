#!/bin/bash

wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
~/.local/scripts/volume-popup.sh
