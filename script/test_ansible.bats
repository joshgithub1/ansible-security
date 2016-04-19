# vim: set ts=2 sw=2 ai et:

load options

@test "ansible working directory is created" {
  run docker run -t -i --entrypoint bash cleanerbot/ansible-security -c "ls /opt/ansible" | grep ansible
  [[ ${output} =~ ansible ]]
}
