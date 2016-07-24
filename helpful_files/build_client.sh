#!/bin/bash

CLIENT_IMAGE="client"

echo "Creating Mock Client"
echo "==========================================================="
docker build -f dockerfiles/dockerfile-client -t $CLIENT_IMAGE .
# docker run -i -t --entrypoint bash client
