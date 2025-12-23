#!/bin/bash
set -e

BACKUP_FILE=$1
VOLUME_NAME=$2

if [ -z "$BACKUP_FILE" ] || [ -z "$VOLUME_NAME" ]; then
    echo "Usage: $0 <backup_file> <volume_name>"
    exit 1
fi

echo "Restoring volume $VOLUME_NAME from $BACKUP_FILE"

# Stop containers using the volume
echo "Stopping containers using the volume..."
docker ps --filter "volume=$VOLUME_NAME" --format "{{.Names}}" | xargs -r docker stop

# Restore the volume
docker run --rm \
    -v $VOLUME_NAME:/target \
    -v $(pwd)/backups:/backup \
    alpine:latest \
    sh -c "rm -rf /target/* && tar -xzf /backup/$BACKUP_FILE -C /target"

# Start containers again
echo "Starting containers..."
docker ps -a --filter "volume=$VOLUME_NAME" --format "{{.Names}}" | xargs -r docker start

echo "Restore completed successfully"
