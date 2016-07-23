#!/bin/bash

CLIENT_IMAGE="client"

echo "Creating Mock Client"
echo "==========================================================="
docker build -f dockerfiles/dockerfile-client -t $CLIENT_IMAGE .

echo "Run and enter Client"
docker run -i -t --entrypoint bash $CLIENT_IMAGE
