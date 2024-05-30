# Ubuntu 18.04 with nvidia-docker2 beta opengl support
FROM nvidia/opengl:1.0-glvnd-devel-ubuntu18.04

# Tools I find useful during development
RUN apt-get update -qq \
 && apt-get install -y -qq \
        build-essential \
        cmake \
        cppcheck \
        gdb \
        git \
        libbluetooth-dev \
        libcwiid-dev \
        libgoogle-glog-dev \
        libspnav-dev \
        libusb-dev \
        libccd-dev \
        libfcl-dev  \
        lsb-release \
        pkg-config \
        g++-8 \
        mercurial \
        python3-dbg \
        python3-empy \
        python3-numpy \
        python3-pip \
        python3-venv \
        ruby2.5 \
        ruby2.5-dev \
        software-properties-common \
        sudo \
        vim \
        wget \
        net-tools \
        iputils-ping \
 && apt-get clean -qq 

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update -qq \
 && apt-get install -y -qq \
    tzdata \
 && ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime \
 && dpkg-reconfigure --frontend noninteractive tzdata \
 && apt-get clean -qq

# install ROS and required packages
# RUN  /bin/sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list' \
# RUN  curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc
# RUN  apt-key add - \
# RUN  gpg --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 
# RUN    gpg --export C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 | sudo tee /usr/share/keyrings/ros.gpg > /dev/null 
# RUN  /bin/sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list' \
RUN  sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt update

RUN  apt-get update

RUN apt-get install -y -qq \
    libpcl-dev \
    libpcl-conversions-dev \
    python-catkin-tools \
    python-rosinstall \
    ros-melodic-desktop \
    ros-melodic-tf2-sensor-msgs \
    ros-melodic-robot-localization \
    ros-melodic-rotors-control \
    ros-melodic-control-toolbox \
    ros-melodic-twist-mux \
    ros-melodic-joy \
    ros-melodic-ros-control \
    python3-vcstool \
    python3-colcon-common-extensions \
    ros-melodic-joystick-drivers \
    ros-melodic-pointcloud-to-laserscan \
    ros-melodic-spacenav-node \
    ros-melodic-pcl-ros \
    ros-melodic-rviz-imu-plugin 

RUN mkdir -p /etc/ros/rosdep/sources.list.d/
RUN  apt-get install curl
RUN apt-get install python-rosdep

# RUN curl -o /etc/ros/rosdep/sources.list.d/20-default.list https://mirrors.ustc.edu.cn/rosdistro/rosdep/sources.list.d/20-default.list
# RUN sed -i 's#raw.githubusercontent.com/ros/rosdistro/master#mirrors.ustc.edu.cn/rosdistro#g' /etc/ros/rosdep/sources.list.d/20-default.list
# RUN export ROSDISTRO_INDEX_URL=https://mirrors.ustc.edu.cn/rosdistro/index-v4.yaml
# RUN rosdep update
# RUN echo 'export ROSDISTRO_INDEX_URL=https://mirrors.ustc.edu.cn/rosdistro/index-v4.yaml' >> ~/.bashrc
ENV  http_proxy="http://127.0.0.1:7890"
ENV  https_proxy="http://127.0.0.1:7890"
# RUN  curl -o /etc/ros/rosdep/sources.list.d/20-default.list https://mirrors.tuna.tsinghua.edu.cn/github-raw/ros/rosdistro/master/rosdep/sources.list.d/20-default.list
# RUN  export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml
# RUN rosdep update
# RUN  echo 'export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml' >> ~/.bashrc
RUN   rosdep init
RUN   rosdep update

# 可以考虑持久化以上环境变量：
# RUN curl -o /etc/ros/rosdep/sources.list.d/20-default.list https://mirrors.tuna.tsinghua.edu.cn/github-raw/ros/rosdistro/master/rosdep/sources.list.d/20-default.list
    # 为 rosdep update 换源
#  RUN   export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml
# RUN    rosdep update
    
#   每次 rosdep update 之前，均需要增加该环境变量
#    为了持久化该设定，可以将其写入 .bashrc 中，例如
# RUN   echo 'export ROSDISTRO_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/rosdistro/index-v4.yaml' >> ~/.bashrc
#  && rosdep init \
RUN apt-get clean -qq
RUN  apt-get update
# sdformat8-sdf conflicts with sdformat-sdf installed from gazebo
# so we need to workaround this using a force overwrite
# Do this before installing ign-gazebo
RUN /bin/sh -c 'echo "deb [trusted=yes] http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' \
 && /bin/sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-prerelease `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-prerelease.list' \
 && /bin/sh -c 'wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -' \
 && /bin/sh -c 'apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654'

# install ign-blueprint
RUN apt-get update -qq \
&&  apt-get install -y -qq \
    ignition-blueprint \
    ros-melodic-ros-ign \
    ignition-dome \
 && apt-get clean -qq

# Add a user with the same user_id as the user outside the container
# Requires a docker build argument `user_id`
ARG user_id
ENV USERNAME developer
RUN useradd -U --uid ${user_id} -ms /bin/bash $USERNAME \
 && echo "$USERNAME:$USERNAME" | chpasswd \
 && adduser $USERNAME sudo \
 && echo "$USERNAME ALL=NOPASSWD: ALL" >> /etc/sudoers.d/$USERNAME

RUN  rosdep update
RUN  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8
# Commands below run as the developer user
USER $USERNAME

# Make a couple folders for organizing docker volumes
RUN mkdir ~/workspaces ~/other

# When running a container start in the developer's home folder
# 在 Dockerfile 中，WORKDIR 指令用于设置工作目录（也称为当前目录），后续的 RUN、CMD、ENTRYPOINT、COPY 和 ADD 指令将在这个目录下执行。如果工作目录不存在，Docker 会自动创建它。
WORKDIR /home/$USERNAME

RUN mkdir -p subt_solution/src \
&& cd subt_solution/src \
&& git config --global http.postBuffer 11048576000 \ 
&& git clone  https://github.com/osrf/subt

WORKDIR /home/$USERNAME/subt_solution

# Install Rotors
# RUN wget https://s3.amazonaws.com/osrf-distributions/subt_robot_examples/releases/subt_robot_examples_latest.tgz
# RUN tar xvf subt_robot_examples_latest.tgz

RUN /bin/bash -c 'source /opt/ros/melodic/setup.bash && catkin_make install'
 
# RUN  cd /home/$USERNAME/subt_solution/src  &&  git clone https://github.com/osrf/subt_seed

WORKDIR /home/$USERNAME/subt_solution/src
COPY subt_solution_launch ./

WORKDIR /home/$USERNAME/subt_solution
RUN /bin/bash -c 'source /opt/ros/melodic/setup.bash && catkin_make install'
RUN /bin/bash -c ' source  ~/subt_solution/install/setup.sh'

# . 是 source 命令的别名，用于在当前 shell 环境中执行脚本
RUN /bin/sh -c 'echo ". /opt/ros/melodic/setup.bash" >> ~/.bashrc' \
 && /bin/sh -c 'echo ". ~/subt_solution/install/setup.sh" >> ~/.bashrc'

# 创建目录
RUN mkdir -p /tmp/ign

# 复制入口点脚本并设置入口点
COPY run_solution.bash ./
ENTRYPOINT ["./run_solution.bash"]

# Customize your image here.
# E.g.:
# ENV PATH="/opt/sublime_text:$PATH"
