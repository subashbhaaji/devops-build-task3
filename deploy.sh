#!/bin/bash
IMAGE_NAME="subashbhaaji/dev"
TAG=${1:-dev}

echo "Stopping existing container..."
docker stop react-container || true
docker rm react-container || true

echo "Pulling latest image and running container on port 80..."
docker pull $IMAGE_NAME:$TAG
docker run -d --name react-container -p 80:80 $IMAGE_NAME:$TAG
