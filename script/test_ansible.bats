# vim: set ts=2 sw=2 ai et:

load options

@test "ansible 2.x is installed" {
  run docker run --volumes-from playbooks-data -t -i --entrypoint bash ansible-security -c "cd /opt/ansible; ansible --version"
  [[ ${output} =~ ansible\ 2\. ]]
}

@test "ansible playbook directory is available" {
 run docker run --volumes-from ${DATA_IMAGE} -t -i --entrypoint bash ${LOCAL_IMAGE} -c "ls -l /etc/ansible"
  [[ ${output} =~ total ]]
}
