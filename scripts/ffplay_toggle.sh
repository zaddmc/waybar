#!/bin/bash

# Get the PID of the first running ffplay instance
PID=$(pgrep -x ffplay)

if [ -z "$PID" ]; then
    #echo "ffplay is not running."
    exit 1
fi

# Check the process state
# 'T' means Stopped/Paused
STATE=$(ps -o state= -p "$PID")

if [ "$STATE" == "T" ]; then
    kill -CONT "$PID"
    #echo "Resumed ffplay ($PID)"
else
    kill -STOP "$PID"
    #echo "Paused ffplay ($PID)"
fi
