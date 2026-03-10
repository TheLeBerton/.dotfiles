#!/bin/bash

STATE_DIR="/tmp/pomodoro"

WORK_DURATION=1500     # 25 min
SHORT_BREAK=300        # 5 min
LONG_BREAK=900         # 15 min
LONG_BREAK_INTERVAL=4  # long break after N pomodoros

mkdir -p "$STATE_DIR"

_read()  { cat "$STATE_DIR/$1" 2>/dev/null; }
_write() { echo "$2" > "$STATE_DIR/$1"; }

get_phase()     { _read phase     || echo "work"; }
get_running()   { _read running   || echo "0"; }
get_end_time()  { _read end_time  || echo "0"; }
get_remaining() { _read remaining; }
get_count()     { _read count     || echo "0"; }

phase_duration() {
    case "$1" in
        work)        echo $WORK_DURATION ;;
        short_break) echo $SHORT_BREAK ;;
        long_break)  echo $LONG_BREAK ;;
    esac
}

advance_phase() {
    local phase count
    phase=$(get_phase)
    count=$(get_count)

    _write running 0
    _write end_time 0
    rm -f "$STATE_DIR/remaining"

    if [ "$phase" = "work" ]; then
        count=$((count + 1))
        _write count "$count"
        if [ $((count % LONG_BREAK_INTERVAL)) -eq 0 ]; then
            _write phase long_break
            _write remaining $LONG_BREAK
            dunstify -a "Pomodoro" -r 9999 -u normal "Pomodoro $count terminé !" "Longue pause méritée (15 min)" &
        else
            _write phase short_break
            _write remaining $SHORT_BREAK
            dunstify -a "Pomodoro" -r 9999 -u normal "Pomodoro $count terminé !" "Pause courte (5 min)" &
        fi
    else
        _write phase work
        dunstify -a "Pomodoro" -r 9999 -u normal "Pause terminée !" "Au travail (25 min)" &
    fi
}

cmd_status() {
    local phase running now remaining end_time count icon class tooltip time_str suffix
    phase=$(get_phase)
    running=$(get_running)
    now=$(date +%s)
    count=$(get_count)

    # Check if timer expired
    if [ "$running" = "1" ]; then
        end_time=$(get_end_time)
        if [ "$now" -ge "$end_time" ]; then
            advance_phase
            phase=$(get_phase)
            running="0"
        fi
    fi

    # Compute remaining for display
    if [ "$running" = "1" ]; then
        remaining=$(( $(get_end_time) - now ))
        [ "$remaining" -lt 0 ] && remaining=0
    else
        remaining=$(get_remaining)
    fi

    case "$phase" in
        work)
            icon="󰔟"
            class="work"
            tooltip="Pomodoro $((count + 1)) — Travail"
            ;;
        short_break)
            icon="󰋊"
            class="short_break"
            tooltip="Pause courte — Pomodoro $count terminé"
            ;;
        long_break)
            icon="󱫐"
            class="long_break"
            tooltip="Longue pause — $count pomodoros complétés"
            ;;
    esac

    if [ -n "$remaining" ] && [ "$remaining" -gt 0 ]; then
        time_str=$(printf "%02d:%02d" $((remaining / 60)) $((remaining % 60)))
    else
        time_str="--:--"
    fi

    suffix=""
    [ "$running" = "0" ] && suffix=" idle"

    printf '{"text": "%s %s", "class": "%s%s", "tooltip": "%s"}\n' \
        "$icon" "$time_str" "$class" "$suffix" "$tooltip"
}

cmd_toggle() {
    local running phase rem now
    running=$(get_running)
    phase=$(get_phase)
    now=$(date +%s)

    if [ "$running" = "1" ]; then
        # Pause: save remaining time
        rem=$(( $(get_end_time) - now ))
        [ "$rem" -lt 0 ] && rem=0
        _write remaining "$rem"
        _write running 0
        _write end_time 0
    else
        # Start or resume
        rem=$(get_remaining)
        if [ -z "$rem" ] || [ "$rem" -le 0 ]; then
            rem=$(phase_duration "$phase")
        fi
        _write end_time $(( now + rem ))
        _write running 1
        rm -f "$STATE_DIR/remaining"
    fi
}

cmd_skip() {
    advance_phase
}

cmd_reset() {
    rm -rf "$STATE_DIR"
    mkdir -p "$STATE_DIR"
}

case "${1:-status}" in
    status) cmd_status ;;
    toggle) cmd_toggle ;;
    skip)   cmd_skip ;;
    reset)  cmd_reset ;;
    *) echo "Usage: $0 {status|toggle|skip|reset}" >&2; exit 1 ;;
esac
