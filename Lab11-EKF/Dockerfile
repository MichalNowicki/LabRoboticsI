FROM ros:noetic-perception

# SETUP ENVS
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# INSTALL SOME ESSENTIAL PROGRAMS
RUN apt-get update     && \
    apt-get install -y    \
        git wget cmake libgoogle-glog-dev libeigen3-dev ros-noetic-rviz python3-rosdep && \
    rm -rf /var/lib/apt/lists/*

# CREATE CATKIN WS
WORKDIR /
RUN mkdir -p /catkin_ws/src/

# DOWNLOAD CODE
WORKDIR /catkin_ws/src/
RUN git clone https://github.com/MichalNowicki/KalmanFilter.git

# DEPENDENCIES
WORKDIR /catkin_ws/
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash;apt-get update;rosdep init;rosdep install --from-paths src --ignore-src -r -y"

# BUILD
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash;catkin_make"


# FILL BASHRC
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
