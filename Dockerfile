FROM docker
ENV PORT=80
RUN apk add git openssh make python3 --update --no-cache
RUN apk add --no-cache ca-certificates

ENV GOLANG_VERSION 1.9.2
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
        bash \
        gcc \
        musl-dev \
        openssl \
        go \
    ; \
    export \
# set GOROOT_BOOTSTRAP such that we can actually build Go
        GOROOT_BOOTSTRAP="$(go env GOROOT)" \
# ... and set "cross-building" related vars to the installed system's values so that we create a build targeting the proper arch
# (for example, if our build host is GOARCH=amd64, but our build env/image is GOARCH=386, our build needs GOARCH=386)
        GOOS="$(go env GOOS)" \
        GOARCH="$(go env GOARCH)" \
        GOHOSTOS="$(go env GOHOSTOS)" \
        GOHOSTARCH="$(go env GOHOSTARCH)" \
    ; \
# also explicitly set GO386 and GOARM if appropriate
# https://github.com/docker-library/golang/issues/184
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
        armhf) export GOARM='6' ;; \
        x86) export GO386='387' ;; \
    esac; \
    \
    wget -O go.tgz "https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz"; \
    echo '665f184bf8ac89986cfd5a4460736976f60b57df6b320ad71ad4cef53bb143dc *go.tgz' | sha256sum -c -; \
    tar -C /usr/local -xzf go.tgz; \
    rm go.tgz; \
    \
    cd /usr/local/go/src; \
    for p in /go-alpine-patches/*.patch; do \
        [ -f "$p" ] || continue; \
        patch -p2 -i "$p"; \
    done; \
    ./make.bash; \
    \
    rm -rf /go-alpine-patches; \
    \
    export PATH="/usr/local/go/bin:$PATH"; \
    go version && \
    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH" && \
    cd $GOPATH/src && \
    mkdir -p github.com/estesp && \
    cd github.com/estesp && \
    git clone https://github.com/estesp/manifest-tool && \
    cd manifest-tool && make binary && make install && \
    apk del .build-deps;

WORKDIR /root
COPY ./daemon.py /usr/bin/mydaemon
EXPOSE 80
CMD ["mydaemon"]
