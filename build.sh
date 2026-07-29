#!/bin/bash
IMAGE_NAME="subashbhaaji/devops-react-app"
TAG=${1:-dev}

echo "Building Docker image with tag: $TAG..."
docker build -t $IMAGE_NAME:$TAG .
