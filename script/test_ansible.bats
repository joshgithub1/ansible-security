# vim: set ts=2 sw=2 ai et:

load options

@test "ansible is installed" {
  run docker run -rm --read-only sometheycallme/ansible-security --version
  [[ ${output} = ansible ]]
}
