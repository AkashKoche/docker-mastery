#!/bin/bash
echo "Building Docker Image..."
docker build -t my-static-website .


echo "Running Tests..."
docker run --rm my-static-website curl -I http://localhost


echo "Pushing to DockerHub..."
docker tag my-static-website <dockerhub-username>/my-static-website:v1.0.0
docker push <dockerhub-username>/my-static-website:v1.0.0
