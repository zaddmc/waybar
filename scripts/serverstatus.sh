#!/usr/bin/env bash
if ping -c 1 homeserver > /dev/null 2>&1; then
    echo $(jq -n --arg ip "Home Server IP: $(getent hosts homeserver | awk '{ print $1}')" '{"text": "󰗠", "class": "online", "tooltip": $ip}')
else
    echo '{"text": "", "class":"offline"}' 
fi
