#!/bin/bash

chosen=$(echo -e "\n󰗽\n\n󰐥" | rofi -dmenu -config ~/.config/rofi/session.rasi -select 1)
case $chosen in
    )
        ~/.scripts/lock.sh # lock
        ;;
    󰗽) # logout
        i3-msg exit
        ;;
    ) # reboot
        systemctl reboot
        ;;
    󰐥) # shutdown
        systemctl poweroff
        ;;
esac

