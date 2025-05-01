# Set image name and tag
IMAGE_NAME="ros_noetic_mavros_controller"
TAG="latest"

# Print information
echo "Building Docker image: $IMAGE_NAME:$TAG"
echo "---------------------------------------------"
docker build -t $IMAGE_NAME:$TAG .