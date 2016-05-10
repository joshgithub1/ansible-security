# vim: set ts=2 sw=2 ai et:

load options

@test "python version is < 3" {
  run docker run -rm --read-only cleanerbot/ansible-security --python -V
  [[ ${output} =~ 2 ]]
}
