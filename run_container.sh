#!/bin/bash

# Remove space after "=" 
MAVROS_CONTROLLER=~/catkin_ws/src/mavros_controllers

docker run -it --rm --privileged --network host \
    -v ${MAVROS_CONTROLLER}:/root/catkin_ws/src/mavros_controllers \
    --env ROS_MASTER_URI=http://localhost:11311 \
    --name=mavros_controller \
    ros_noetic_mavros_controller:latest \
    bash
