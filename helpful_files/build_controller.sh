#!/bin/bash

DATA_IMAGE="staging-data"
CONTROLLER_IMAGE="ansible-controller"
AUTOSTAGER_IMAGE="autostager"

echo "Creating Staging Volume, Ansible Controller"
echo "==========================================="
docker create -v /opt/staging --name $DATA_IMAGE alpine true 
docker build -f dockerfiles/dockerfile-ansible -t $CONTROLLER_IMAGE .  

echo "Running the Ansible Controller (webserver) and run interactively"
docker run --volumes-from $DATA_IMAGE:ro -p 8080:8080 --env-file /home/core/env_vars -i -t $CONTROLLER_IMAGE bash
