#!/usr/bin/env bash

# Get stats for /home (or your specific user home)
HOME_USAGE=$(df -h /home/zadd | awk 'NR==2 {print $5}' | sed 's/%//')
HOME_FREE=$(df -h /home/zadd | awk 'NR==2 {print $4}')
HOME_SIZE=$(df -h /home/zadd | awk 'NR==2 {print $2}')

# Get stats for root /
ROOT_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
ROOT_FREE=$(df -h / | awk 'NR==2 {print $4}')
ROOT_SIZE=$(df -h / | awk 'NR==2 {print $2}')

# Construct the tooltip text with clean formatting
TOOLTIP="<b>Disk Usage Details</b>\n"
TOOLTIP+="――――――――――――――――――――――――\n"
TOOLTIP+="<b>/home/zadd:</b> \t${HOME_USAGE}% used (${HOME_FREE} free of ${HOME_SIZE})\n"
TOOLTIP+="<b>/ :</b> \t\t\t${ROOT_USAGE}% used (${ROOT_FREE} free of ${ROOT_SIZE})"

# Output JSON for Waybar
printf '{"text": "%s", "tooltip": "%s", "class": "disk"}\n' "$HOME_USAGE" "$TOOLTIP"
