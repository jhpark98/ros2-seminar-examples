#!/bin/bash

# X11 display settings
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

# Check if a container name is provided, otherwise use the default "ros2"
if [ -z "$1" ]; then
    CONTAINER_NAME="ros2"
else
    CONTAINER_NAME="$1"
fi

IMAGE_NAME="ros2-foxy"

# Run the Docker container with the appropriate configurations
echo "Running the Docker container '$CONTAINER_NAME'..."

# Allow the Docker container to access X11 on your host machine
xhost +local:docker

docker run -it --rm \
        --name "$CONTAINER_NAME" \
        --net=host \
        --ipc=host \
        --pid=host \
        -e DISPLAY=$DISPLAY \
        -v $XSOCK:$XSOCK:rw \
        -v $XAUTH:$XAUTH \
        -e XAUTHORITY=$XAUTH \
        "$IMAGE_NAME" /bin/bash

# Check if the container ran successfully
if [ $? -ne 0 ]; then
    echo "Failed to start the container. Exiting..."
    exit 1
else
    echo "Docker container '$CONTAINER_NAME' is running."
fi
