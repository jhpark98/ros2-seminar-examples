# Use the official ROS Foxy desktop image as the base
FROM osrf/ros:foxy-desktop

# Set environment variables for the ROS 2 workspace
ENV ROS_WS=/root/robot_ws

# Add ROS 2 repository sources to ensure correct packages
RUN apt-get update && apt-get install -y curl gnupg2 lsb-release && \
    curl -sSL http://repo.ros2.org/repos.key | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list' && \
    apt-get update

# Install necessary dependencies for building ROS 2 packages and setting locale
RUN apt-get install -y \
    python3-colcon-common-extensions \
    git \
    locales \
    ros-foxy-desktop \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8

# Create the workspace directory
RUN mkdir -p $ROS_WS/src

# Change to the workspace src directory
WORKDIR $ROS_WS/src

# Clone the desired repository
RUN git clone https://github.com/jhpark98/ros2-seminar-examples.git

# Change to the workspace directory
WORKDIR $ROS_WS

# Use bash for RUN commands to allow sourcing
SHELL ["/bin/bash", "-c"]

# Source ROS and build the workspace
RUN source /opt/ros/foxy/setup.bash && colcon build --symlink-install

# Source the workspace on startup
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc && \
    echo "source $ROS_WS/install/setup.bash" >> ~/.bashrc

# Set the default command to run a shell
CMD ["/bin/bash"]
