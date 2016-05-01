# vim: set ts=2 sw=2 ai et:

load options

@test "python version is < 3" {
  run docker run -t -i --entrypoint bash cleanerbot/ansible-security -c "python -V"
  [[ ${output} =~ 2 ]]
}

@test "boto is imported" {
  run docker run -t -i --entrypoint bash cleanerbot/ansible-security -c "python; import boto; python exit()"
  [[ ${output} =~ ]]
}
@test "ansible working directory is created" {
  run docker run -t -i --entrypoint bash cleanerbot/ansible-security -c "ls /opt/ansible"
  [[ ${output} =~ ansible ]]
}

@test "ansible can ping" {
  run docker run -t -i --entrypoint bash cleanerbot/ansible-security -c "ansible all -m ping"
  [[ ${output} =~ 127.0.0.1 ]]
}

@test "gocd agent is installed" {
  run docker run -t -i --entrypoint bash cleanerbot/ansible-security -c "ls /etc/default"
  [[ ${output} =~ go-agent ]]
}
