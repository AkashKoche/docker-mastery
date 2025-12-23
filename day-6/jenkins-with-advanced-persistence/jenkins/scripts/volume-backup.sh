#!/bin/bash
set -e

VOLUME_NAME=$1
BACKUP_NAME=${2:-${VOLUME_NAME}_backup_$(date +%Y%m%d_%H%M%S)}

if [ -z "$VOLUME_NAME" ]; then
    echo "Usage: $0 <volume_name> [backup_name]"
    echo "Available volumes:"
    docker volume ls
    exit 1
fi

echo "Backing up volume: $VOLUME_NAME to $BACKUP_NAME.tar"

# Create backup using a temporary container
docker run --rm \
    -v $VOLUME_NAME:/source \
    -v $(pwd)/backups:/backup \
    alpine:latest \
    tar -czf /backup/$BACKUP_NAME.tar.gz -C /source .

echo "Backup created: backups/$BACKUP_NAME.tar.gz"
