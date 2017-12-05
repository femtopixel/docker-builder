FROM docker
ENV PORT=80
RUN apk add git openssh php7 make --update --no-cache
WORKDIR /root
CMD ["sh", "-c", "php", "-S", "0.0.0.0:${PORT:-80}", "listener.php"]
