import json
import os
import sys

# set ansible controller 
ansible_controller = None;

#check if ansible controller_ip is in env_vars
if 'controller_ip' in os.environ:
    ansible_controller = os.environ['controller_ip']

#placeholder for whitelist - check webserver.py
flag_whitelist = []

arguments = sys.argv[1:]

handle_and_branch = arguments[0].split('_', 1)
handle = handle_and_branch[0]
branch = handle_and_branch[1]
flags = []
for arg in arguments:
    if arg.startswith('-'):
    	flags.append(arg)
for arg in arguments:
    if arg.endswith('.yml'):
	playbook = arg
# logging
#print "Handle: " + handle
#print "Branch: " + branch
#print "Playbook: " + playbook
#print "Flags: ",  flags

flag_list = []
for flag in flags:
    flag_argument = arguments[arguments.index(flag) + 1]
    flag_dict = {'flag': flag, 'argument': flag_argument}
    flag_list.append(flag_dict)

# json to be passed to webserver on controller
data_dict = {
	     'git_handle': handle,
	     'branch_name': branch,
	     'flags': flag_list,
	     'playbook': playbook
	     }

# set environment variable ANSIBLE_HOSTS
# ANSIBLE_HOSTS established the project root directory
# when using variable data in playbooks 
os.putenv('ANSIBLE_HOSTS', '/home/user/ansible-security/hosts')

# logging
#json_data = json.dumps(data_dict)
#print json_data

# When testing locally set curl command to LOCAL command

# REMOTE ------- 
# Send curl command to controller
# curl_cmd = "curl -v -X POST -d '{0}' {1}/play".format(json_data, ansible_controller)

# LOCAL -------
# Send Ansible command to local Ansible controller
# test curl_cmd locally
curl_cmd = "ansible-playbook fixtures/etc/ansible/" + playbook
os.chdir('/home/user/ansible-security')
os.system(curl_cmd)
