#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2 + $4)}')

# Get top 5 CPU-consuming processes
top_processes=$(ps -eo comm,%cpu --sort=-%cpu | head -n 6 | tail -n 5 | awk '{print $1 " (" $2 "%)"}' | paste -sd '\n' -)

# Properly escape for JSON using printf and no jq
tooltip=$(printf "%s" "$top_processes" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

echo "{\"text\": \"󰍛 ${cpu_usage}%\", \"tooltip\": \"${tooltip}\"}"

