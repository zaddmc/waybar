#!/usr/bin/env bash
target="ssh.clankersrefuge.dk"

if ping -c 2 $target > /dev/null 2>&1; then
    echo $(jq -n --arg ip "Home Server IP: $(getent hosts $target | awk '{ print $1}')" '{"text": "󰗠", "class": "online", "tooltip": $ip}')
else
    echo '{"text": "", "class":"offline"}' 
fi
