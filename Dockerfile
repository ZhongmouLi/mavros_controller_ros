# Start from the ROS Noetic desktop image
FROM osrf/ros:noetic-desktop

# Install basic system utilities and developer tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        tigervnc-standalone-server tigervnc-common \
        supervisor wget curl gosu git sudo python3-pip tini \
        build-essential vim sudo lsb-release locales \
        bash-completion tzdata terminator && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install catkin tools
RUN apt-get update && \
    apt-get install -y python3-catkin-tools python3-osrf-pycommon

# Install MAVROS and MAVROS-extras and MAVROS-msgs
RUN apt-get update && \
    apt-get install -y \
        ros-noetic-mavros \
        ros-noetic-mavros-extras \
        ros-noetic-mavros-msgs

# Install GeographicLib datasets (for GPS / MAVROS full functionality)
RUN wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh && \
    bash ./install_geographiclib_datasets.sh && \
    rm install_geographiclib_datasets.sh

# Set the working directory (optional)
WORKDIR /root/catkin_ws

# (Optional) Setup entrypoint
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
