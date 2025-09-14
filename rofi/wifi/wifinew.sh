#!/bin/bash

# Alternative WiFi menu script for rofi (right-click action)
# Shows WiFi settings and advanced options

# WiFi interface
WIFI_INTERFACE=$(nmcli device status | grep wifi | head -n1 | awk '{print $1}')

if [ -z "$WIFI_INTERFACE" ]; then
    notify-send "WiFi Error" "No WiFi interface found"
    exit 1
fi

# Get current status
CURRENT_SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
WIFI_STATUS=$(nmcli radio wifi)

# Build menu options
OPTIONS=""

if [ "$WIFI_STATUS" == "enabled" ]; then
    OPTIONS="📶 Turn WiFi Off"
else
    OPTIONS="📶 Turn WiFi On"
fi

if [ ! -z "$CURRENT_SSID" ]; then
    OPTIONS="$OPTIONS\n📋 Show Connection Info\n🔄 Reconnect to $CURRENT_SSID\n🚫 Forget $CURRENT_SSID"
fi

OPTIONS="$OPTIONS\n🔍 Scan Networks\n⚙️ Network Settings\n🔧 Edit Connections"

# Show rofi menu
CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "WiFi Settings" -theme ~/.config/rofi/wifi/wifi-notification.rasi)

case "$CHOSEN" in
    "📶 Turn WiFi Off")
        nmcli radio wifi off
        notify-send "WiFi" "WiFi disabled"
        ;;
    "📶 Turn WiFi On")
        nmcli radio wifi on
        notify-send "WiFi" "WiFi enabled"
        ;;
    "📋 Show Connection Info")
        INFO=$(nmcli connection show "$CURRENT_SSID" | grep -E "(IP4.ADDRESS|IP4.GATEWAY|IP4.DNS)" | awk '{print $2 ": " $3}')
        notify-send "Connection Info for $CURRENT_SSID" "$INFO"
        ;;
    "🔄 Reconnect to"*)
        nmcli connection down "$CURRENT_SSID" && nmcli connection up "$CURRENT_SSID"
        notify-send "WiFi" "Reconnected to $CURRENT_SSID"
        ;;
    "🚫 Forget"*)
        nmcli connection delete "$CURRENT_SSID"
        notify-send "WiFi" "Forgot network $CURRENT_SSID"
        ;;
    "🔍 Scan Networks")
        nmcli device wifi rescan
        notify-send "WiFi" "Network scan completed"
        # Launch the main wifi script
        ~/.config/rofi/wifi/wifi.sh &
        ;;
    "⚙️ Network Settings")
        # Try to open network settings with different possible applications
        if command -v nm-connection-editor >/dev/null; then
            nm-connection-editor &
        elif command -v gnome-control-center >/dev/null; then
            gnome-control-center network &
        elif command -v systemsettings5 >/dev/null; then
            systemsettings5 kcm_networkmanagement &
        else
            notify-send "Error" "No network settings application found"
        fi
        ;;
    "🔧 Edit Connections")
        CONNECTIONS=$(nmcli -t -f name connection show | rofi -dmenu -i -p "Select connection to edit" -theme ~/.config/rofi/wifi/wifi-notification.rasi)
        if [ ! -z "$CONNECTIONS" ]; then
            if command -v nm-connection-editor >/dev/null; then
                nm-connection-editor -e "$CONNECTIONS" &
            else
                notify-send "Info" "Connection: $CONNECTIONS"
            fi
        fi
        ;;
esac