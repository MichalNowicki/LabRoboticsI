xhost +local:root

# BUILD THE IMAGE
ROS_IMAGE="rob/image12"
docker build -f Dockerfile -t $ROS_IMAGE ./..
