#!/usr/bin/env bash

status=$(playerctl metadata --format '{{status}}' 2>/dev/null)
title=$(playerctl metadata --format '{{title}} - {{artist}}' 2>/dev/null)

if [ "$status" == "Playing" ]; then
    echo " $title"
elif [ "$status" == "Paused" ]; then
    echo "▶ $title"
else
    echo "󰎇 No media playing"
fi
