#!/usr/bin/env python

from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
from optparse import OptionParser

class RequestHandler(BaseHTTPRequestHandler):
        
    def do_POST(self):
        
        request_path = self.path
       	if request_path == '/play':
	    request_headers = self.headers
            content_length = request_headers.getheaders('content-length')
            length = int(content_length[0]) if content_length else 0
 	    post_data = self.rfile.read(length)
	    args_list = post_data.split()
	    if '/' not in args_list[0]:
		self.send_response(400)
		return
	    branch_and_book = args_list[0].split('/')
	    branch = branch_and_book[0]
	    playbook = branch_and_book[1]
	    if not (playbook.endswith('.yml') or playbook.endswith('.yaml')):
		self.send_response(400, "bad playbook extension") # playbooks must have one of these exts
		return
	    print "Branch Name: " + branch
            print "Playbook Name: " + playbook
            flags = []
            for arg in args_list:
		if arg[0] == '-':
		    flags.append(arg)
	    print args_list
	    print flags
            self.send_response(200)
        else:
	    self.send_response(409)
        
def main():
    port = 8080
    print('Listening on localhost:%s' % port)
    server = HTTPServer(('', port), RequestHandler)
    server.serve_forever()

        
if __name__ == "__main__":
    parser = OptionParser()
    parser.usage = ("Creates an http-server that will echo out any GET or POST parameters\n"
                    "Run:\n\n"
                    "   reflect")
    (options, args) = parser.parse_args()
    
    main()
