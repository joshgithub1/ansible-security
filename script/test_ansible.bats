# vim: set ts=2 sw=2 ai et:

load options

# note: BATS does not respect this syntax: ${DATA_IMAGE}

@test "ansible-controller: Ansible 2.x is installed" {
  run docker run --volumes-from $DATA_IMAGE -t -i --entrypoint bash $CONTROLLER_IMAGE -c "cd /opt/ansible; ansible --version"
  [[ ${output} =~ ansible\ 2\. ]]
}

docker run --volumes-from ansible-data:ro -p 8080:8080 -d ansible-controller

@test "ansible-controller: staging directory is in path" {
 run docker run --volumes-from $DATA_IMAGE -t -i --entrypoint bash $CONTROLLER_IMAGE -c "ls -l /opt | grep staging"
  [[ ${output} =~ staging ]]
}

@test "autostager: autostager is in path" {
 run docker run --volumes-from $DATA_IMAGE -t -i --entrypoint bash $AUTOSTAGER_IMAGE -c "ls -l /autostager"
  [[ ${output} =~ autostager.py ]]
}
