# vim: set ts=2 sw=2 ai et:

load options

@test "docker ansible image is created" {
  run docker images
  [[ ${output} =~ansible]]
}

@test "ansible working directory is created" {
  skip "this isn't working yet"
  run docker run -t -i --entrypoint bash cleanerbot/ansible-security -c "ls /opt/ansible" | grep ansible
  [[ ${output} =~ ansible ]]
}
