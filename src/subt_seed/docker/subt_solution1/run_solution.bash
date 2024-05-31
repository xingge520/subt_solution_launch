#!/usr/bin/env bash

# source ${PATH_TO_SOLUTION_WS_SETUP_BASH}
. /opt/ros/melodic/setup.bash
. ~/subt_solution/install/setup.sh

roslaunch subt_solution_launch robot.launch name:=X1
