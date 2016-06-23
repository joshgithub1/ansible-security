import json
import os
import sys

ansible_controller = os.environ['controller_ip']

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

print "Handle: " + handle
print "Branch: " + branch
print "Playbook: " + playbook
print "Flags: ",  flags

flag_list = []
for flag in flags:
    flag_argument = arguments[arguments.index(flag) + 1]
    flag_dict = {'flag': flag, 'argument': flag_argument}
    flag_list.append(flag_dict)

data_dict = {
	     'git_handle': handle,
	     'branch_name': branch,
	     'flags': flag_list,
	     'playbook': playbook
	     }

json_data = json.dumps(data_dict)
print json_data

curl_cmd = "curl -v -X POST -d '{0}' {1}/play".format(json_data, ansible_controller)
os.system(curl_cmd)



