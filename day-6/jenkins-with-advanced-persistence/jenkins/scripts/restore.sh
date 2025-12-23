#!/bin/bash
set -e

BACKUP_DIR="/var/jenkins_backups"
JENKINS_HOME="/var/jenkins_home"

if [ -z "$1" ]; then
    echo "Usage: $0 <backup_file>"
    echo "Available backups:"
    ls -la "${BACKUP_DIR}"/*.tar.gz 2>/dev/null || echo "No backups found"
    exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "${BACKUP_FILE}" ]; then
    echo "Backup file not found: ${BACKUP_FILE}"
    exit 1
fi

echo "Stopping Jenkins..."
docker-compose stop jenkins

echo "Restoring from backup: ${BACKUP_FILE}"
rm -rf "${JENKINS_HOME}/*"
tar -xzf "${BACKUP_FILE}" -C "${JENKINS_HOME}"

echo "Setting proper permissions..."
chown -R 1000:1000 "${JENKINS_HOME}"

echo "Starting Jenkins..."
docker-compose start jenkins

echo "Restore completed successfully"
