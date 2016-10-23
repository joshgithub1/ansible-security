#!/usr/bin/env python

from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
from optparse import OptionParser
import json
import os
import re
import subprocess
import shlex

playbook_whitelist = {
    '-v': False,
    '-i': True,
    '-M': True,
    '-e': True,
    '-f': True,
    '-k': False,
    '-K': False,
    '-U': True,
    '-T': True,
    '-s': False,
    '-u': True,
    '-c': True,
    '-l': True
}


class RequestHandler(BaseHTTPRequestHandler):

    @classmethod
    def log(cls, a_string):
        print a_string

    @classmethod
    def alphafy(cls, a_string):
        pattern = "[^a-z0-9_]"
        return re.sub(pattern, "_", a_string, flags=re.IGNORECASE)

    def do_POST(self):
        request_path = self.path
        if request_path == '/play':
            self.play()
        elif request_path == '/run':
            self.run()
        else:
            self.send_response(404, 'unsupported endpoint')

    def play(self):
        content_length = self.headers.getheaders('content-length')
        length = int(content_length[0]) if content_length else 0
        post_data = json.loads(self.rfile.read(length))
        self.log(post_data)

        playbook = post_data['playbook']
        self.log(playbook)

        if not playbook:
            self.send_response(400, 'playbook not sent')
            return

        if not playbook.endswith('.yml'):
            self.send_response(400, 'bad playbook extension')
            return

        flags = post_data['flags']
        self.log(flags)

        # Build a command based on provided flags and arguments.
        command = "ansible-playbook"
        for flag in flags:
            self.log(flag)

            if flag['flag'] not in playbook_whitelist.keys():
                self.send_response(400, "invalid flag")
                return

            if playbook_whitelist[flag['flag']] and not flag['argument']:
                self.send_response(
                    400, "provided argument to non argument flag"
                )
                self.log(flag['argument'])
                return

            command += " {0}".format(flag['flag'])
            if flag['argument']:
                command += " {0}".format(flag['argument'])

        # base_dir: must add the env_var file with
        # docker run --env-file /home/core/env_vars
        directory = post_data['git_handle'] + '/' + post_data['branch_name']
        base_dir = os.environ['base_dir']
        safe_dir = self.alphafy(directory)
        command += " {0}/{1}/{2}".format(base_dir, safe_dir, playbook)

        # Use this to set ANSIBLE_HOSTS environment variable
        # as base_dir, safe_dir
        path = os.path.join(base_dir, safe_dir)
        os.chdir(path)
        os.putenv('ANSIBLE_HOSTS', path + '/'"hosts")

        proc = subprocess.Popen(shlex.split(command), stdout=subprocess.PIPE, shell=False)
        (out, _err) = proc.communicate()

        self.log("program output: " + out)
        self.log(command)
        self.log(path)

        # test pass string output from proc
        #
        self.send_response(200, out)
        return

    def run(self):
        self.send_response(200, "not implemented yet")
        return


def main():
    port = 8080
    print 'Listening on localhost:%s' % port
    server = HTTPServer(('', port), RequestHandler)
    server.serve_forever()


if __name__ == "__main__":
    parser = OptionParser()
    parser.usage = (
        "Creates an http-server to echo any GET or POST parameters\n"
        "Run:\n\n"
        "   reflect")
    (options, args) = parser.parse_args()

    main()
