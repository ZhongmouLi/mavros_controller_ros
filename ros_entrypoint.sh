#!/bin/bash
set -e

# Source ROS setup.bash if it exists
if [ -f "/opt/ros/$ROS_DISTRO/setup.bash" ]; then
    source "/opt/ros/$ROS_DISTRO/setup.bash"
fi

# Then execute whatever command was passed to the container
exec "$@"
