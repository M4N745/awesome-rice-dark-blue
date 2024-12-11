#!/bin/bash

# Get current brightness
get_brightness() {
    brightnessctl get
}

# Get maximum brightness
get_max_brightness() {
    brightnessctl max
}

# Calculate and print brightness percentage
print_brightness() {
    current=$(get_brightness g)
    max=$(get_max_brightness m)
    echo "$((100 * current / max))%"
}

NOTIF_ID_FILE="/tmp/brightness_notif_id"

case "$1" in
  up)
    brightnessctl set +10%
    NOTIF_ID=$(cat "$NOTIF_ID_FILE" 2>/dev/null || echo 0)
    NEW_NOTIF_ID=$(notify-send -p -r "$NOTIF_ID" "Brightness" "$(print_brightness)")
    echo "$NEW_NOTIF_ID" > "$NOTIF_ID_FILE"
    ;;
  down)
    brightnessctl set 10%-
    NOTIF_ID=$(cat "$NOTIF_ID_FILE" 2>/dev/null || echo 0)
    NEW_NOTIF_ID=$(notify-send -p -r "$NOTIF_ID" "Brightness" "$(print_brightness)")
    echo "$NEW_NOTIF_ID" > "$NOTIF_ID_FILE"
    ;;
  *)
    print_brightness
    ;;
esac
