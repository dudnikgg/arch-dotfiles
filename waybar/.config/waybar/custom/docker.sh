#!/bin/bash
# ~/.config/waybar/scripts/docker.sh

# Check if Docker is running
if ! systemctl is-active --quiet docker; then
    echo '{"text": "󰡨 Down", "tooltip": "Docker service not running", "class": "down"}'
    exit 0
fi

# Get running containers
running=$(docker ps -q | wc -l)
total=$(docker ps -a -q | wc -l)

# Get names of running containers for tooltip
if [ "$running" -gt 0 ]; then
    container_names=$(docker ps --format '{{.Names}}' | sed 's/^/• /')
    tooltip=$(echo -e "$container_names\n\n$running running of $total total containers" | sed ':a;N;$!ba;s/\n/\\n/g')
    css_class="running"
else
    tooltip="No running containers ($total total containers)"
    css_class="stopped"
fi

echo "{\"text\": \"󰡨 ${running}/${total}\", \"tooltip\": \"$tooltip\", \"class\": \"$css_class\"}"

