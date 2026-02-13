#!/bin/bash

if hyprctl clients | grep -q "class: chromium-browser"; then
	hyprctl dispatch focuswindow chromium
else
	chromium-browser "https://profile-v3.intra.42.fr/" "https://github.com/" "http://localhost:3000/" &
fi
