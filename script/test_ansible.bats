# vim: set ts=2 sw=2 ai et:

load options

# note: BATS does not respect this syntax: ${DATA_IMAGE}

@test "ansible-controller: Ansible 2.x is installed and running" {
  run docker run --volumes-from $DATA_IMAGE:ro -t -i --entrypoint bash $CONTROLLER_IMAGE -c "cd /opt/ansible; ansible --version"
  [[ ${output} =~ ansible\ 2\. ]]
}

@test "ansible-controller: Autostager staging directory for contributor branches is in path" {
 run docker run --volumes-from $DATA_IMAGE:ro -t -i --entrypoint bash $CONTROLLER_IMAGE -c "ls -l /opt | grep staging"
  [[ ${output} =~ staging ]]
}

@test "autostager: Autostager python script is in path" {
 run docker run --volumes-from $DATA_IMAGE:rw -t -i --entrypoint bash $AUTOSTAGER_IMAGE -c "ls -l /autostager/autostager"
  [[ ${output} =~ autostager.py ]]
}

@test "ansible-controller: fixtures path is set" {
 # check to see if the $FIXTURES_DATA_IMAGE is properly set iun path for controller to see playbook
 run docker run -i -t --name=voltest -p 8080:8080 --env-file helpful_files/env_vars -v /home/ubuntu/ansible-security/fixtures/etc/ansible:/opt/staging/cleanerbot_master/ansible-security --entrypoint bash ansible-controller -c "ls -l /opt/staging/cleanerbot_master/ansible-security"
 [[ ${output} =~ play_test.yml ]]
}

@test "ansible-controller: webserver responds to curl" {
 # run docker run -d --name=webtest -p 8080:8080 --volumes-from $FIXTURES_DATA_IMAGE:ro ansible-controller
 run docker run -d --name=webtest -p 8080:8080 --env-file helpful_files/env_vars -v /home/ubuntu/ansible-security/fixtures/etc/ansible:/opt/staging/cleanerbot_master/ansible-security ansible-controller
   ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' webtest)
   port=8080
 run curl -v -X POST -d '{"branch_name": "master", "git_handle": "cleanerbot", "flags": [{"flag": "-i", "argument": "inventory"}], "playbook": "ansible-security/play_test.yml"}' http://${ip}:${port}/play
  [[ ${output} =~ trying ]]
}
