FROM nvidia/cuda:11.1-devel-ubuntu20.04

# SETUP ENVS
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# INSTALL ROS
# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1-latest.list

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO noetic

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-ros-core=1.5.0-1* \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
#COPY ./ros_entrypoint.sh /
#ENTRYPOINT ["/ros_entrypoint.sh"]

# INSTALL SOME ESSENTIAL PROGRAMS
RUN apt-get update     && \
    apt-get install -y    \
        git wget cmake libgoogle-glog-dev libeigen3-dev ros-noetic-perception ros-noetic-rviz python3-rosdep ros-noetic-roslint unzip && \
    rm -rf /var/lib/apt/lists/*

# CREATE CATKIN WS
WORKDIR /
RUN mkdir -p /catkin_ws/src/

# DOWNLOAD CODE
WORKDIR /catkin_ws/src/
RUN git clone https://github.com/OTL/cv_camera

# COPY YOLO
WORKDIR /catkin_ws/
COPY yolo-object-detection.zip .
RUN unzip yolo-object-detection.zip
RUN rm yolo-object-detection.zip

# DEPENDENCIES
WORKDIR /catkin_ws/
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash;apt-get update;rosdep init;rosdep update;rosdep install --from-paths src --ignore-src -r -y"

# BUILD
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash;catkin_make -DCMAKE_BUILD_TYPE=Release"


# FILL BASHRC
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
