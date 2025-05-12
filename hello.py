#!/usr/bin/env python3
import json

data = {
    "text": "Hello",
    "tooltip": "Funny Tooltip",
}

try:
    with open("/tmp/sway_notify_test", "r") as file:
        data["tooltip"] = file.read().strip()
except FileNotFoundError:
    data["tooltip"] = "File not found"


print(json.dumps(data))
