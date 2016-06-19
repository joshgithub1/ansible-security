# vim: set ts=2 sw=2 ai et:

load options

# note: BATS does not respect this syntax: ${DATA_IMAGEi}

@test "ansible-controller: Ansible 2.x is installed" {
  run docker run --volumes-from playbooks-data -t -i --entrypoint bash ansible-security -c "cd /opt/ansible; ansible --version"
  [[ ${output} =~ ansible\ 2\. ]]
}

@test "ansible-controller: playbook fixtures directory is mounted" {
 run docker run --volumes-from playbooks-data -t -i --entrypoint bash ansible-security -c "ls -l /etc/ansible"
  [[ ${output} =~ total ]]
}

@test "ansible-controller: Go v1.6.x is installed" {
 run docker run --volumes-from playbooks-data -t -i --entrypoint bash ansible-security -c "go version"
  [[ ${output} =~ go1.6\. ]]
}

@test "autostager: latest version is installed" {
 run docker run --volumes-from playbooks-data -t -i --entrypoint bash autostager -c "pip list | grep autostager"
  [[ ${output} =~ autostager ]]
}

@test "ansible-controller: captainhook is in path" {
 run docker run  -t -i --entrypoint bash ansible-security -c "command -v captainhook"
 [[ ${output} =~ /usr/bin/captainhook ]]
}

@test "ansible-controller: captainhook is executable" {
 run docker run  -t -i --entrypoint captainhook ansible-security --help
 [[ ${output} =~ Usage ]]
}

@test "ansible-controller: captainhook responds to webhooks" {
 docker run  -d --name=hooktest -P --volumes-from playbooks-data ansible-security
 if [[ x$DOCKER_HOST = x ]]; then
   # use local network namespace
   ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' hooktest)
   port=8080
 else
   # accomodate remote docker execution.
   ip=$(echo ${DOCKER_HOST} | awk -F/ '{print $NF}' | cut -d: -f0)
   port=$(docker port hooktest | awk -F: '{print $NF}')
 fi
 run curl --stderr - -X POST http://${ip}:${port}/ep1
 [[ ${output} =~ hello ]]
}

@test "ansible-controller: captainhook testplaybook passed to ansible" {
 docker run  -d --name=hooktest -P --volumes-from playbooks-data ansible-security
 if [[ x$DOCKER_HOST = x ]]; then
   # use local network namespace
   ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' hooktest)
   port=8080
 else
   # accomodate remote docker execution.
   ip=$(echo ${DOCKER_HOST} | awk -F/ '{print $NF}' | cut -d: -f0)
   port=$(docker port hooktest | awk -F: '{print $NF}')
 fi
 run curl --stderr - -X POST http://${ip}:${port}/play_test
 [[ ${output} =~ hello ]]
}
