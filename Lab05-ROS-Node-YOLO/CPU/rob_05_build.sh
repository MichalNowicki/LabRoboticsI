xhost +local:root

# BUILD THE IMAGE
ROS_IMAGE="rob/image05"
docker build -f Dockerfile -t $ROS_IMAGE ./..
