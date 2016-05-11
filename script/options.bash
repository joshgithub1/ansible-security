# vim: set ts=2 sw=2 ai et:

if [[ -n ${CIRCLECI} ]]; then
  CAPS=''
else
  CAPS='--cap-drop all'
fi

DATA_IMAGE="playbooks-data:latest"
LOCAL_IMAGE="ansible-security:latest"
PUBLISHED_IMAGE="sometheycallme/ansible-controller:latest"
