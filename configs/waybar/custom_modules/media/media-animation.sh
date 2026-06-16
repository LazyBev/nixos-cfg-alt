#!/usr/bin/env bash

while :; do
  status=$(playerctl metadata --format '{{status}}' 2>/dev/null)

  if [ "$status" == "Playing" ]; then
      echo ""
  elif [ "$status" == "Paused" ]; then
      echo "▶"
  else
      echo "󰎇 No media playing"
  fi
  sleep 0.1
done
