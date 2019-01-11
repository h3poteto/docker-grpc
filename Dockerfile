FROM golang:1.11.4-alpine3.8

RUN set -ex && \
    apk add --no-cache \
    git \
    build-base \
    tar \
    gzip \
    curl \
    protobuf

ENV GOPATH /go
ENV APP_DIR ${GOPATH}/src/github.com

ENV PATH $PATH:/go/bin

RUN set -x \
    && adduser -D -u 1000 go \
    && echo 'go:password' | chpasswd \
    && mkdir -p ${APP_DIR} \
    && chown -R go:go /go

WORKDIR ${APP_DIR}
USER go

RUN set -x && \
    go get -u google.golang.org/grpc && \
    go get -u github.com/golang/protobuf/protoc-gen-go
