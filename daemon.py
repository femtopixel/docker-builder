#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
import json, subprocess, time


class RequestHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        print("incomming http: ", self.path)
        content_length = int(self.headers['Content-Length'])
        content = self.rfile.read(content_length)
        self.send_response(200)
        subprocess.run(["/root/update.sh", json.loads(content)['version']], stdout=subprocess.PIPE)

httpd = HTTPServer(('', 80), RequestHandler)

print(time.asctime(), "Server Starts")

try:
    httpd.serve_forever()
except KeyboardInterrupt:
    pass

httpd.server_close()
print(time.asctime(), "Server Stops")
