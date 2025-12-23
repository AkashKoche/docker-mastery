#!/bin/bash

echo "=== Docker Volume Monitor ==="
echo "Timestamp: $(date)"
echo

# Volume usage
echo "Volume Usage:"
docker system df -v | grep -A 10 "VOLUME NAME"

echo
echo "Volume Details:"
docker volume ls -q | while read volume; do
    size=$(docker run --rm -v $volume:/data alpine du -sh /data 2>/dev/null | cut -f1)
    container=$(docker ps -a --filter volume=$volume --format "{{.Names}}" | head -1)
    echo "Volume: $volume | Size: ${size:-unknown} | Used by: ${container:-none}"
done

echo
echo "Large Files in Volumes:"
docker volume ls -q | while read volume; do
    echo "=== $volume ==="
    docker run --rm -v $volume:/data alpine find /data -type f -size +10M -exec ls -lh {} \; 2>/dev/null || echo "No large files or error accessing volume"
done
