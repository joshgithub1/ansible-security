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

@test "ansible-controller: fixtures path is set for testing" {
 # check to see if the $FIXTURES_DATA_IMAGE is properly set iun path for controller to see playbook
 run docker run -i -t --name=voltest -p 8080:8080 --env-file helpful_files/env_vars -v /home/ubuntu/ansible-security/fixtures/etc/ansible:/opt/staging/cleanerbot_master/ansible-security --entrypoint bash ansible-controller -c "ls -l /opt/staging/cleanerbot_master/ansible-security"
 [[ ${output} =~ play_test.yml ]]
}

@test "ansible-controller: fixtures playbook executes locally (in container)" {
 # check to see if ansible can execute the playbook locally
 run docker run -i -t --name=playtest --env-file helpful_files/env_vars -v /home/ubuntu/ansible-security/fixtures/etc/ansible:/opt/staging/cleanerbot_master/ansible-security --entrypoint bash ansible-controller -c "ansible-playbook -i inventory /opt/staging/cleanerbot_master/ansible-security/play_test.yml"
 [[ ${output} =~ PLAY ]]
}

# Regex expression assertions example https://github.com/ztombol/bats-assert
# @test "assert_output() regular expression matching" {
#  run echo 'Foobar 0.1.0'
#  assert_output --regexp '^Foobar v[0-9]+\.[0-9]+\.[0-9]$'
# }

@test "ansible-controller: webserver responds to curl and playbook executes remotely (outside container)" {
 # run docker run -d --name=webtest -p 8080:8080 --volumes-from $FIXTURES_DATA_IMAGE:ro ansible-controller
 run docker run -d --name=webtest -p 8080:8080 --env-file helpful_files/env_vars -v /home/ubuntu/ansible-security/fixtures/etc/ansible:/opt/staging/cleanerbot_master/ansible-security ansible-controller
   ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' webtest)
   port=8080
   curl -v -X POST -d '{"branch_name": "master", "git_handle": "cleanerbot", "flags": [{"flag": "-i", "argument": "inventory"}], "playbook": "ansible-security/play_test.yml"}' http://${ip}:${port}/play > $TMP
  run echo $TMP | grep RECAP
 [[ ${output} =~ RECAP ]]
}
