# vim: set ts=2 sw=2 ai et:

if [[ -n ${CIRCLECI} ]]; then
  CAPS=''
else
  CAPS='--cap-drop all'
fi

CLIENT_IMAGE="client:latest"
FIXTURES_DATA_IMAGE="fixtures-data"
DATA_IMAGE="staging-data"
CONTROLLER_IMAGE="ansible-controller:latest"
AUTOSTAGER_IMAGE="autostager:latest"
PUBLISHED_IMAGE="sometheycallme/ansible-controller:latest"
PUBLISHED_AUTOSTAGER_IMAGE="sometheycallme/ansible-autostager:latest"
