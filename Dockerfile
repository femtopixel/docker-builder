FROM docker
ENV PORT=80
RUN apk add git openssh make python3 py3-pip ca-certificates gnupg --update --no-cache
WORKDIR /root
COPY ./daemon.py /usr/bin/mydaemon
EXPOSE 80
CMD ["mydaemon"]
