#!/usr/bin/env bash

# Show default state first
echo '{"text": "Nothing playing", "tooltip": "No media players running", "alt": "none", "class": "stopped"}'

# -F keeps the connection open and waits for changes
playerctl -a metadata --format '{"text": "{{title}} — {{artist}}", "tooltip": "{{playerName}} : {{artist}} - {{title}}", "alt": "{{status}}", "class": "{{status}}"}' -F 2>/dev/null | \
    while read -r line; do
    CURRENT_PID=$(pgrep -x ffplay)
    if [ -z "$CURRENT_PID" ]; then
        STATE_VAL="Noise is not running"
    else
        STATE=$(ps -o state= -p "$CURRENT_PID" | tr -d ' ')
        if [[ "$STATE" == "S" || "$STATE" == "R" ]]; then
            STATE_VAL="Noise is running"
        else
            STATE_VAL="Noise is paused or broken"
        fi
    fi
    if [[ -z "$line" ]]; then
        EMPTY_LINE='{"text": "Nothing playing", "tooltip": "No media players running", "alt": "none", "class": "stopped"}'
        newline=$(echo "$line" | jq --arg val "$STATE_VAL" '.tooltip += "\n"+$val' -c)
    else
        # Use jq to append the state to the tooltip
        jq --arg val "$STATE_VAL" '.tooltip += "\n"+$val' -c <<< "$line"
    fi
done
