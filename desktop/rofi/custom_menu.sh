#!/bin/bash

THEME="~/.config/rofi/squared.rasi"

case "$ROFI_RETV" in
    0)
        echo -e " APPS\x00icon\x1fapplication-menu"
        echo -e " THEME\x00icon\x1fgames-config-theme"
        echo -e " SCRIPTS\x00icon\x1fsystem-run"
        echo -e " POWER\x00icon\x1fsystem-log-out"
        ;;
    1)
        case "$1" in
            " APPS")
                rofi -show drun -show-icons -theme "$THEME" &
                ;;
            " THEME")
                ~/.config/rofi/theme.sh &
                ;;
            " SCRIPTS")
                ~/.config/rofi/scripts-menu.sh &
                ;;
            " POWER")
                wlogout &
                ;;
        esac
        ;;
esac
