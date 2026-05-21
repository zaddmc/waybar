#!/usr/bin/env bash

# A simple file to persist the state (0 or 1)
STATE_FILE="/tmp/waybar_signal_state"

if [ ! -f "$STATE_FILE" ]; then
    exit 0
fi

# If the file EXISTS, read its contents to determine the class/color
STATE=$(cat "$STATE_FILE")

if [[ "$STATE" == error* ]]; then
    echo "{\"class\": \"error\", \"tooltip\": \"$STATE\"}"
else
    echo "{\"class\": \"working\", \"tooltip\": \"$STATE\"}"
fi

