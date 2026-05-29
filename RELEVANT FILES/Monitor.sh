#!/bin/bash

# Variables
CONTAINER_NAME="webcon"
LOG_DIR="/opt/container-monitor/logs"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="$LOG_DIR/monitor_$(date '+%Y-%m-%d').log"

# Get CPU and Memory usage
STATS=$(docker stats --no-stream --format \
"CPU:{{.CPUPerc}} MEM:{{.MemUsage}}" \
$CONTAINER_NAME)

# Write to log
echo "[$TIMESTAMP] $STATS" >> $LOG_FILE
