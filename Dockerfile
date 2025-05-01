# Start from the ROS Noetic desktop image
FROM osrf/ros:noetic-desktop

# Install basic system utilities and developer tools
# RUN apt-get update && \
#     DEBIAN_FRONTEND=noninteractive apt-get install -y \
#         tigervnc-standalone-server tigervnc-common \
#         supervisor wget curl gosu git python3-pip tini \
#         build-essential vim lsb-release locales \
#         bash-completion tzdata terminator && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        supervisor wget curl gosu git python3-pip tini \
        build-essential vim lsb-release locales \
        bash-completion tzdata  && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


# Install catkin tools
RUN apt-get update && \
    apt-get install -y python3-catkin-tools python3-osrf-pycommon && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install MAVROS and MAVROS-extras and MAVROS-msgs
RUN apt-get update && \
    apt-get install -y \
        ros-noetic-mavros \
        ros-noetic-mavros-extras \
        ros-noetic-mavros-msgs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install GeographicLib datasets (for GPS / MAVROS full functionality)
RUN wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh && \
    bash ./install_geographiclib_datasets.sh && \
    rm install_geographiclib_datasets.sh

# Set up catkin workspace
RUN mkdir -p /catkin_ws/src

WORKDIR /catkin_ws

# Initialize catkin workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin init"

# Copy local source code into the container workspace
COPY src/mavros_controllers /catkin_ws/src/mavros_controllers

# Build the catkin workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin build"

# Set entrypoint and default command
COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]