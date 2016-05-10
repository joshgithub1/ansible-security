# vim: set ts=2 sw=2 ai et:

load options

@test "ansible is installed ~=1.9" {
  run docker run --rm --read-only sometheycallme/ansible-security --version
  [[ ${output} ~= 1.9 ]]
}
