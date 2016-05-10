# vim: set ts=2 sw=2 ai et:

load options

@test "ansible is installed >=2.0" {
  run docker run -rm --read-only sometheycallme/ansible-security --version
  [[ ${output} = 2 ]]
}
