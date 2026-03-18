#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$THEME_DIR")"
COLORS="$THEME_DIR/colors.sh"

apply() {
    local tpl="$1" out="$2"
    python3 - "$COLORS" "$tpl" "$out" <<'PYEOF'
import sys, re

colors = {}

# Parse colors.sh
with open(sys.argv[1]) as f:
    for line in f:
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        if '=' not in line:
            continue
        k, _, v = line.partition('=')
        k = k.strip()
        v = v.strip()
        v = re.sub(r'\s+#.*$', '', v)  # strip inline comments
        v = v.strip('"\'')
        colors[k] = v

# Auto-generate rgba + hyprland variants from plain hex colors (#rrggbb)
def hex_to_rgb(h):
    h = h.lstrip('#')
    return int(h[0:2], 16), int(h[2:4], 16), int(h[4:6], 16)

derived = {}
for name, value in colors.items():
    if re.fullmatch(r'#[0-9a-fA-F]{6}', value):
        r, g, b = hex_to_rgb(value)
        # CSS rgba variants with common opacities
        for pct, alpha in [('20', 0.2), ('30', 0.3), ('50', 0.5), ('80', 0.8),
                            ('85', 0.85), ('90', 0.9), ('96', 0.96)]:
            derived[f'{name}_{pct}'] = f'rgba({r}, {g}, {b}, {alpha})'
        # Hyprland rgba hex format (rrggbbAA)
        h = value.lstrip('#').lower()
        derived[f'{name}_hypr']    = f'rgba({h}ff)'   # fully opaque
        derived[f'{name}_hypr_00'] = f'rgba({h}00)'   # fully transparent
        # Hex + alpha suffix variants (e.g. for dunst separator_color)
        for alpha_hex in ['40', '80', 'cc', 'f2']:
            derived[f'{name}_hex{alpha_hex}'] = f'{value}{alpha_hex}'

colors.update(derived)

# Apply template
with open(sys.argv[2]) as f:
    content = f.read()

content = re.sub(r'\{\{(\w+)\}\}', lambda m: colors.get(m.group(1), m.group(0)), content)

with open(sys.argv[3], 'w') as f:
    f.write(content)
PYEOF
    echo "  ✓ $(realpath --relative-to="$ROOT_DIR" "$out")"
}

echo "Applying theme from colors.sh..."

apply "$ROOT_DIR/waybar/style.css.tpl"                  "$ROOT_DIR/waybar/style.css"
apply "$ROOT_DIR/hypr/appearance/colors.conf.tpl"       "$ROOT_DIR/hypr/appearance/colors.conf"
apply "$ROOT_DIR/hypr/hyprlock.conf.tpl"                "$ROOT_DIR/hypr/hyprlock.conf"
apply "$ROOT_DIR/dunst/dunstrc.tpl"                     "$ROOT_DIR/dunst/dunstrc"
apply "$ROOT_DIR/mako/config.tpl"                       "$ROOT_DIR/mako/config"
apply "$ROOT_DIR/swaylock/config.tpl"                   "$ROOT_DIR/swaylock/config"
apply "$ROOT_DIR/rofi/rounded-purple-dark.rasi.tpl"     "$ROOT_DIR/rofi/rounded-purple-dark.rasi"

echo ""
echo "Done! Reload your apps to apply changes:"
echo "  hyprctl reload"
echo "  pkill waybar && waybar &"
echo "  pkill dunst  && dunst &"
