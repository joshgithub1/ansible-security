# vim: set ts=2 sw=2 ai et:

load options

@test "ansible 2.x is installed" {
  run docker run --rm --read-only ${IMAGE_NAME_TAG} --version
  [[ ${output} =~ ansible\ 2\. ]]
}
