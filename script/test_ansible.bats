# vim: set ts=2 sw=2 ai et:

load options

# note: BATS does not respect this syntax: ${DATA_IMAGE}

@test "ansible-controller: Ansible 2.x is installed" {
  run docker run --volumes-from $DATA_IMAGE:ro -t -i --entrypoint bash $CONTROLLER_IMAGE -c "cd /opt/ansible; ansible --version"
  [[ ${output} =~ ansible\ 2\. ]]
}

@test "ansible-controller: staging directory is in path" {
 run docker run --volumes-from $DATA_IMAGE:ro -t -i --entrypoint bash $CONTROLLER_IMAGE -c "ls -l /opt | grep staging"
  [[ ${output} =~ staging ]]
}

@test "autostager: autostager is in path" {
 run docker run --volumes-from $DATA_IMAGE:rw -t -i --entrypoint bash $AUTOSTAGER_IMAGE -c "ls -l /autostager"
  [[ ${output} =~ autostager ]]
}

@test "ansible-controller: webserver is in path and responding to webhooks" {
 run docker run -d --name=webtest -p 8080:8080 --volumes-from staging-data:ro ansible-controller
 if [[ x$DOCKER_HOST = x ]]; then
 # use local network namespace
   ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' webtest)
   port=8080
 else
 # accomodate remote docker execution.
   ip=$(echo ${DOCKER_HOST} | awk -F/ '{print $NF}' | cut -d: -f0)
   port=$(docker port hooktest | awk -F: '{print $NF}')
fi
 run curl -v -X POST -d '{"branch_name": "testplaybook", "git_handle": "sometheycallme", "flags": [{"flag": "-i", "argument": "inventory"}], "playbook": "/playbooks/gitclone/clone-repo.yml"}' http://${ip}:${port}/play
  [[ ${lines[2]} =~ "POST /play HTTP/1.1" ]]
}
