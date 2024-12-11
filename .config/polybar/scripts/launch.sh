#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bars
polybar top-left -r &
polybar spotify-bar -r &
polybar top-center -r &
polybar top-second-right -r &
polybar top-right -r &
polybar power-bar -r &
