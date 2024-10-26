#!/bin/bash

# Define the image name
IMAGE_NAME="ros2-foxy"

# Check if Dockerfile exists in the current directory
if [ ! -f Dockerfile ]; then
    echo "Dockerfile not found! Please ensure the Dockerfile is in the current directory."
    exit 1
fi

# Build the Docker image
echo "Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Docker image built successfully: $IMAGE_NAME"
else
    echo "Docker image build failed!"
    exit 1
fi

