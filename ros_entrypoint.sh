#!/bin/bash
set -e

# Source ROS core environment
source /opt/ros/noetic/setup.bash

# Source catkin workspace if it exists
if [ -f /catkin_ws/devel/setup.bash ]; then
    echo "Sourcing /catkin_ws/devel/setup.bash"
    source /catkin_ws/devel/setup.bash
else
    echo "WARNING: /catkin_ws/devel/setup.bash not found; workspace may not be built yet"
fi

# Show current ROS_PACKAGE_PATH for debugging
echo "ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH"

# Execute passed command or start bash by default
exec "$@"
