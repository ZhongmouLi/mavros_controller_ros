#!/bin/bash
# Get absolute path with realpath

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Script directory: $SCRIPT_DIR"


MAVROS_CONTROLLER="${SCRIPT_DIR}/src/mavros_controllers"
echo "MAVROS_CONTROLLER: $MAVROS_CONTROLLER"

# Try Docker with absolute path and explicit quotes
docker run -it --rm --privileged --network host \
    -v "$MAVROS_CONTROLLER:/catkin_ws/src/mavros_controllers" \
    --env ROS_MASTER_URI=http://localhost:11311 \
    --name=mavros_controller \
    ros_noetic_mavros_controller:latest \
    bash