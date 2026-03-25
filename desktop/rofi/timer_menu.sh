#!/bin/bash

THEME="~/.config/rofi/squared.rasi"
TIMER_FILE="/tmp/timers.txt"


add_timer() {
	name=$(date "+%d/%m/%Y %H:%M:%S")
	duration=$(rofi -dmenu -p "Duration" -theme "$THEME" <<< "")
	if [[ "$duration" == *:* ]]; then
		IFS=':' read -r min sec <<< "$duration"
		duration=$(( min * 60 + sec ))
	fi
	(
		sleep "$duration"
		sed -i "/^$name|/d" "$TIME_FILE"
		notify-send "Timer finished" "$name"
	) &
	end=$(( $(date +%s) + duration ))
	echo "$name|$end|$!" >> "$TIMER_FILE"
	notify-send "Timer launched" "$name - ${duration}s"
}

check_timers() {
	if [[ ! -f "$TIMER_FILE" ]] || [[ ! -s "$TIMER_FILE" ]]; then
		notify-send "No active timers"
	fi
	list=""
	now=$(date +%s)
	while IFS='|' read -r name end pid; do
		remaining=$(( end - now ))
		if (( remaining > 0 )); then
			min=$(( remaining / 60 ))
			sec=$(( remaining % 60 ))
			list+="$name - ${min}m ${sec}s remaining\n"
		fi
	done < "$TIMER_FILE"
	if [[ -z "$list" ]]; then
		notify-send "No active timers"
	else
		echo -e "$list" | rofi -dmenu -p "Active timers" -theme "$THEME" > /dev/null
	fi
}


timer_menu() {
	options=" Add Timer\n Check Timers"
	chosen=$(echo -e "$options" | rofi -dmenu -p "Timers" -theme "$THEME")
	case $chosen in
		" Add Timer")
			add_timer ;;
		" Check Timers")
			check_timers ;;
	esac
}

timer_menu
