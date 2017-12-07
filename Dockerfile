FROM docker
ENV PORT=80
RUN apk add git openssh make python3 --update --no-cache
WORKDIR /root
