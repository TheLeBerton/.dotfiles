#!/bin/bash

# WiFi menu script for rofi
# Shows available networks and allows connection

# Get WiFi interface name
WIFI_INTERFACE=$(nmcli device status | grep wifi | head -n1 | awk '{print $1}')

if [ -z "$WIFI_INTERFACE" ]; then
    notify-send "WiFi Error" "No WiFi interface found"
    exit 1
fi

# Scan for networks
nmcli device wifi rescan

# Get list of available networks
NETWORKS=$(nmcli -t -f SSID,SECURITY,SIGNAL device wifi list | sort -t: -k3 -nr | awk -F: '!seen[$1]++ {if($1!="") print $1 " (" $2 ") [" $3 "%]"}')

# Add disconnect option if connected
CURRENT_SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
if [ ! -z "$CURRENT_SSID" ]; then
    NETWORKS="🔓 Disconnect from $CURRENT_SSID\n$NETWORKS"
fi

# Show rofi menu
CHOSEN=$(echo -e "$NETWORKS" | rofi -dmenu -i -p "WiFi Networks" -theme ~/.config/rofi/wifi/wifi-notification.rasi)

if [ ! -z "$CHOSEN" ]; then
    if [[ "$CHOSEN" == "🔓 Disconnect"* ]]; then
        # Disconnect from current network
        nmcli device disconnect "$WIFI_INTERFACE"
        notify-send "WiFi" "Disconnected from $CURRENT_SSID"
    else
        # Extract SSID from chosen option
        SSID=$(echo "$CHOSEN" | sed 's/ (.*//')

        # Check if network requires password
        SECURITY=$(nmcli -t -f SSID,SECURITY device wifi list | grep "^$SSID:" | cut -d: -f2)

        if [[ "$SECURITY" == *"WPA"* ]] || [[ "$SECURITY" == *"WEP"* ]]; then
            # Network requires password
            PASSWORD=$(rofi -dmenu -password -p "Password for $SSID" -theme ~/.config/rofi/wifi/wifi-notification.rasi)
            if [ ! -z "$PASSWORD" ]; then
                if nmcli device wifi connect "$SSID" password "$PASSWORD"; then
                    notify-send "WiFi" "Connected to $SSID"
                else
                    notify-send "WiFi Error" "Failed to connect to $SSID"
                fi
            fi
        else
            # Open network
            if nmcli device wifi connect "$SSID"; then
                notify-send "WiFi" "Connected to $SSID"
            else
                notify-send "WiFi Error" "Failed to connect to $SSID"
            fi
        fi
    fi
fi