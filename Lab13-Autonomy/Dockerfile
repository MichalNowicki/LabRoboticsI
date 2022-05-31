FROM osrf/ros:noetic-desktop-full 

# SETUP ENVS
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# INSTALL SOME ESSENTIAL PROGRAMS
RUN apt-get update     && \
    apt-get install -y    \
        git ros-noetic-rqt-* ros-noetic-joy ros-noetic-teleop-twist-joy ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc ros-noetic-rgbd-launch ros-noetic-depthimage-to-laserscan ros-noetic-rosserial-arduino ros-noetic-rosserial-python ros-noetic-rosserial-server ros-noetic-rosserial-client ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro ros-noetic-compressed-image-transport ros-noetic-rqt-image-view ros-noetic-gmapping ros-noetic-navigation ros-noetic-interactive-markers ros-noetic-dwa-local-planner ros-noetic-image-transport ros-noetic-cv-bridge ros-noetic-vision-opencv python3-opencv libopencv-dev ros-noetic-image-proc git vim pip && \
    rm -rf /var/lib/apt/lists/*

# INSTALL SOME ESSENTIAL PROGRAMS
RUN pip3 install opencv-contrib-python

# CREATE CATKIN WS
RUN mkdir -p /catkin_ws/src/

# DOWNLOAD TURTLEBOT3
WORKDIR /catkin_ws/src
RUN git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
RUN git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3.git
RUN git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
RUN git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3_autorace_2020.git

# BUILD WORKSPACE
WORKDIR /catkin_ws
RUN /bin/bash -c ". /opt/ros/noetic/setup.bash; catkin_make"

# FILL BASHRC
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN echo "export TURTLEBOT3_MODEL=waffle_pi" >> ~/.bashrc
