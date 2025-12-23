#!/bin/bash

echo "Starting Docker cleanup..."

# Remove stopped containers
echo "Removing stopped containers..."
docker container prune -f

# Remove unused images
echo "Removing unused images..."
docker image prune -af

# Remove unused volumes (be careful!)
echo "Removing unused volumes..."
docker volume prune -f

# Remove unused networks
echo "Removing unused networks..."
docker network prune -f

# Clean up build cache
echo "Cleaning build cache..."
docker builder prune -af

echo "Cleanup completed!"
docker system df
