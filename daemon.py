#!/usr/bin/env python3

import socket, json, subprocess

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('', 80))
server.listen()
while True:
    content = b""
    client = server.accept()
    while not content.endswith(u"\r\n"):
        content = content + client.recv(1024)
    client.close()
    subprocess.run(["VERSION=" + json.loads(content)['version'], "/root/update.sh"], stdout=subprocess.PIPE)
