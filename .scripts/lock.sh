#!/bin/bash
rm -f /tmp/screen.png
scrot /tmp/screen.png
convert /tmp/screen.png -blur 0x10 /tmp/screen.png
i3lock --image=/tmp/screen.png
