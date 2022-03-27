xhost +local:root

# BUILD THE IMAGE
ROS_IMAGE="rob/image05"
ROS_CONTAINER="LabRobotics05"

XAUTH=/tmp/.docker.xauth
 if [ ! -f $XAUTH ]
 then
     xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
     if [ ! -z "$xauth_list" ]
     then
         echo $xauth_list | xauth -f $XAUTH nmerge -
     else
         touch $XAUTH
     fi
     chmod a+r $XAUTH
 fi
 
docker stop $ROS_CONTAINER || true && docker rm $ROS_CONTAINER || true

docker run -it \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --privileged \
    --network=host \
    --name="$ROS_CONTAINER" \
    $ROS_IMAGE \
    /bin/bash
