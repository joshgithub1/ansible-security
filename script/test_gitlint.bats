# vim: set ts=2 sw=2 ai et:

load options

# note: BATS does not respect this syntax: ${DATA_IMAGE}

@test "gitlint: gitlint is in path and responds to commands" {
 # test gitlint installation and response
 run docker run -t -i --entrypoint bash $CLIENT_IMAGE -c "cd /ansible-security; gitlint --help"
  [[ ${output} =~ Usage ]]
}

@test "gitlint: security conformity field checker is in place" {
 # test gitlint against a commit with gitlint-hook
}
