#!/bin/bash

#
# Run this image (ephemerally) locally, and show the app's URL
#

container_port=3000

git_repo_base_dir=$(git rev-parse --show-toplevel)
git_repo_name=$(basename "$git_repo_base_dir")
git_repo_branch=$(git rev-parse --abbrev-ref HEAD)

image_tag="$git_repo_name:$git_repo_branch"

docker build -t "$image_tag" "$git_repo_base_dir"

random_port=$(ruby -rsocket -e"puts TCPServer.new(0).addr[1]")
docker run -d --rm -p $random_port:$container_port $image_tag

echo -e "\n\n  The server should be available at http://localhost:$random_port\n\n"
