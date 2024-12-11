#!/bin/bash

# Get the currently playing status
STATUS=$(playerctl --player=spotify status 2>/dev/null)

if [ "$STATUS" == "Playing" ]; then
	MAX_LENGTH=29
	OUTPUT=$(playerctl --player=spotify metadata --format '{{artist}} - {{title}}')
	if [ ${#OUTPUT} -gt $MAX_LENGTH ]; then
		echo "${OUTPUT:0:$MAX_LENGTH}..."
	else
    		echo "$OUTPUT"
	fi
elif [ "$STATUS" == "Paused" ]; then
    echo "Paused"
else
    echo "Not Playing"
fi

