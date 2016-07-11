#!/bin/bash

DATA_IMAGE="staging-data"
CONTROLLER_IMAGE="ansible-controller"
AUTOSTAGER_IMAGE="autostager"

echo "Creating Staging Volume, Ansible Controller, and Autostager"
echo "==========================================================="
docker create -v /opt/staging --name $DATA_IMAGE alpine true 
docker build -f dockerfiles/dockerfile-autostager -t $AUTOSTAGER_IMAGE .

echo "Running the Ansible Controller and Autostager"
docker run -i --volumes-from $DATA_IMAGE:rw --env-file /home/core/env_vars $AUTOSTAGER_IMAGE
