#!/bin/bash

#
# Run this image (ephemerally) locally, and show the app's URL
#

container_port=3000
container_name="raas-dev"

git_repo_base_dir=$(git rev-parse --show-toplevel)
git_repo_name=$(basename "$git_repo_base_dir")
git_repo_branch=$(git rev-parse --abbrev-ref HEAD)

image_tag="$git_repo_name:$git_repo_branch"

docker build -t "$image_tag" "$git_repo_base_dir"

docker stop "$container_name"
docker rm "$container_name"

random_port=$(ruby -rsocket -e"puts TCPServer.new(0).addr[1]")
docker run -d \
  --name "$container_name" \
  -p $random_port:$container_port \
  -v $git_repo_base_dir/app/db:/app/db \
  $image_tag

# echo -e "\n\n  The server should be available at http://localhost:$random_port"
# echo -e "                                    http://localhost:$random_port/api/v1/reply\n\n"

# open "http://localhost:$random_port/live/reply"

subl -s - <<EOF

  The server should be available at http://localhost:$random_port
                                    http://localhost:$random_port/api/v1/reply
                                    http://localhost:$random_port/live/reply?q=%28%28%28

  CLOSE THIS FILE TO STOP THE SERVER AND DESTROY THE CONTAINER!

EOF

echo "Stoping $container_name..."
docker stop "$container_name"
echo "...done."
echo "Removing $container_name..."
docker rm "$container_name"
echo "...done."