# vim: set ts=2 sw=2 ai et:

load options

@test "ansible working directory is created" {
  run docker run -t -i --entrypoint bash cleanerbot/ansible-security -c "ls /opt/ansible"
  [[ ${output} =~ ansible ]]
}

@test "ansible can ping" {
  run docker run -t -i --entrypoint bash cleanerbot/ansible-security -c "ansible all -m ping"
  [[ ${output} =~ 127.0.0.1 ]]
}
