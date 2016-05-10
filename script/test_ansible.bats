# vim: set ts=2 sw=2 ai et:

load options

@test "ansible version is >= 2" {
  run docker run -rm --read-only cleanerbot/ansible-security
  [[ ${output} =~ 2 ]]
}
