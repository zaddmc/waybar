#!/usr/bin/env bash

# Show default state first
echo '{"text": "Nothing playing", "tooltip": "No media players running", "alt": "none", "class": "stopped"}'

playerctl -a metadata --format '{"text": "{{title}} - {{artist}}", "tooltip": "{{playerName}} : {{artist}} - {{title}}", "alt": "{{status}}", "class": "{{status}}"}' -F 2>/dev/null | \
while read -r line; do
    if [[ -z "$line" ]]; then
        echo '{"text": "Nothing playing", "tooltip": "No media players running", "alt": "none", "class": "stopped"}'
    else
        echo "$line"
    fi
done
