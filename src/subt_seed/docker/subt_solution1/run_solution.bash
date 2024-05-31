#!/usr/bin/env bash

# source ${PATH_TO_SOLUTION_WS_SETUP_BASH}
source /opt/ros/melodic/setup.bash
source ~/subt_solution/install/setup.sh

roslaunch subt_solution_launch robot.launch name:=X1
