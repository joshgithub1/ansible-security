# vim: set ts=2 sw=2 ai et:

if [[ -n ${CIRCLECI} ]]; then
  CAPS=''
else
  CAPS='--cap-drop all'
fi

FIXTURES_DATA_IMAGE="fixtures-data"
DATA_IMAGE="staging-data"
CONTROLLER_IMAGE="ansible-controller:latest"
AUTOSTAGER_IMAGE="autostager:latest"
PUBLISHED_IMAGE="sometheycallme/ansible-controller:latest"
