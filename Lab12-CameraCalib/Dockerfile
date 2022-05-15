FROM ros:melodic-ros-core

# INSTALLING
RUN apt-get update && apt-get install -y python-setuptools \
  python-rosinstall ipython libeigen3-dev libboost-all-dev \
  doxygen libopencv-dev ros-melodic-vision-opencv \
  ros-melodic-image-transport-plugins ros-melodic-cmake-modules \
  software-properties-common wget \
  libpoco-dev python-matplotlib python-scipy python-git \
  python-pip ipython libtbb-dev libblas-dev liblapack-dev \
  python-catkin-tools libv4l-dev python-catkin-tools python-wxversion python-wxtools python-igraph libcairo2-dev eog
RUN pip install cairocffi

# WORKSPACE
RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws

# KALIBR
RUN git clone https://github.com/ethz-asl/kalibr /catkin_ws/src/kalibr
RUN catkin init && catkin config --extend /opt/ros/melodic/ --merge-devel -DCMAKE_BUILD_TYPE=Release -j4 && catkin build

# SETUP
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
