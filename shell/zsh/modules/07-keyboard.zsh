#!/usr/bin/env zsh

if [[ "$IS_42" -eq 1 ]]; then
    xkbcomp -I"$HOME/.xkb" - "$DISPLAY" <<EOF
xkb_keymap {
    xkb_keycodes { include "evdev+aliases(qwerty)" };
    xkb_types    { include "complete" };
    xkb_compat   { include "complete" };
    xkb_symbols  { include "pc+realpdv+inet(evdev)+capslock(ctrl_modifier)" };
    xkb_geometry { include "pc(pc105)" };
};
EOF
fi
