# vim: set ts=2 sw=2 ai et:

load options

# note: BATS does not respect this syntax: ${DATA_IMAGE}

@test "opencontrol: in path and installed" {
  run docker run -t -i --entrypoint bash $OPENCONTROL_IMAGE -c "compliance-masonry"
  [[ ${output} =~ NAME: ]]
}
