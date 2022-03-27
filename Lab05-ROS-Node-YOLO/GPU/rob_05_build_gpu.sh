xhost +local:root

# BUILD THE IMAGE
ROS_IMAGE="rob/image05gpu"
docker build -f Dockerfile -t $ROS_IMAGE ./..
