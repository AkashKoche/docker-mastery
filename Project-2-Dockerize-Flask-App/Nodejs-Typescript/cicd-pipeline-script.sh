#!/bin/bash
echo "Building Docker image..."
docker build -t my-node-app .

echo "Running tests..."
docker run --rm my-node-app npm test

echo "Pushing to Docker Hub..."
docker tag my-node-app <your-dockerhub-username>/my-node-app:v1.0.0
docker push <your-dockerhub-username>/my-node-app:v1.0.0
