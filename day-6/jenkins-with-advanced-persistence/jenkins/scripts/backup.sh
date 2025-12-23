#!/bin/bash
set -e

BACKUP_DIR="/var/jenkins_backups"
JENKINS_HOME="/var/jenkins_home"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="jenkins_backup_${TIMESTAMP}.tar.gz"

echo "Starting Jenkins backup at $(date)"

# Create backup
tar -czf "${BACKUP_DIR}/${BACKUP_FILE}" \
    --exclude="*/workspace/*" \
    --exclude="*/caches/*" \
    --exclude="*/tmp/*" \
    -C "${JENKINS_HOME}" .

# Keep only last 7 backups
ls -t "${BACKUP_DIR}"/jenkins_backup_*.tar.gz | tail -n +8 | xargs -r rm -f

echo "Backup completed: ${BACKUP_FILE}"
echo "Backup size: $(du -h "${BACKUP_DIR}/${BACKUP_FILE}" | cut -f1)"
