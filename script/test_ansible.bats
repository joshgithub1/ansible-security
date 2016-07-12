# vim: set ts=2 sw=2 ai et:

load options

# note: BATS does not respect this syntax: ${DATA_IMAGE}

@test "ansible-controller: Ansible 2.x is installed and running" {
  run docker run --volumes-from $FIXTURES_DATA_IMAGE:ro -t -i --entrypoint bash $CONTROLLER_IMAGE -c "cd /opt/ansible; ansible --version"
  [[ ${output} =~ ansible\ 2\. ]]
}

@test "ansible-controller: Autostager staging directory for contributor branches is in path" {
 run docker run --volumes-from $FIXTURES_DATA_IMAGE:ro -t -i --entrypoint bash $CONTROLLER_IMAGE -c "ls -l /opt | grep staging"
  [[ ${output} =~ staging ]]
}

@test "autostager: Autostager python script is in path" {
 run docker run --volumes-from $FIXTURES_DATA_IMAGE:rw -t -i --entrypoint bash $AUTOSTAGER_IMAGE -c "ls -l /autostager/autostager"
  [[ ${output} =~ autostager.py ]]
}

@test "ansible-controller: webserver responds to curl" {
 run docker run -d --name=webtest -p 8080:8080 --volumes-from $FIXTURES_DATA_IMAGE:ro ansible-controller
 if [[ x$DOCKER_HOST = x ]]; then
 # use local network namespace
   ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' webtest)
   port=8080
 else
 # accomodate remote docker execution.
   ip=$(echo ${DOCKER_HOST} | awk -F/ '{print $NF}' | cut -d: -f0)
   port=$(docker port hooktest | awk -F: '{print $NF}')
fi
 output =$(run curl -v -X POST -d '{"branch_name": "master", "git_handle": "cleanerbot", "flags": [{"flag": "-i", "argument": "hosts"}], "playbook": "fixtures/etc/ansible/play_test.yml"}' http://${ip}:${port}/play | grep TASK)
  # we curl and run 'ansible-playbook' against /opt/staging/cleanerbot_master/ansible-security/fixtures/etc/ansible/play_test.yml
  # the full path is seeded by webserver.py with `ANSIBLE_HOSTS` + git_handle + branch_name + path
  [[ $output =~ TASK ]]
}
