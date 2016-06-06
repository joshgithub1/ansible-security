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
