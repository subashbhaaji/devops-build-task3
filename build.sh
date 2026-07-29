#!/bin/bash
IMAGE_NAME="subashbhaaji/dev"
TAG=${1:-dev}

echo "Building Docker image with tag: $TAG..."
docker build -t $IMAGE_NAME:$TAG .
