FROM docker
ENV PORT=80
RUN apk add git openssh php7 php7-json make --update --no-cache
WORKDIR /root
COPY ./listener.php /root/listener.php
COPY ./daemon.sh /usr/bin/daemon
CMD ["/usr/bin/daemon"]
