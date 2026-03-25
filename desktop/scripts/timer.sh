#!/bin/bash

target=$1
start=$SECONDS


while true; do
	elapsed=$(( SECONDS - start ))
	remaining=$(( target - elapsed ))
	printf "\r[DEBUG] Remaining: %02d:%02d" $(( remaining / 60 )) $(( remaining % 60 ))
	if (( remaining <= 0 )); then
		break
	fi
	sleep 1
done
echo -e "\n[DEBUG] Timer done"

