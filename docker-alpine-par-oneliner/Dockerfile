FROM alpine:latest

ARG EXEC_FILE

RUN apk add \
        build-base \
        perl \
        perl-app-cpanminus \
        perl-dev \
        wget \
        zip \
 && true

RUN cpanm -n \
        PAR::Packer \
 && true

WORKDIR /build

RUN pp -e 'print "Hello, Inline\n"' \
 && mv a.out $EXEC_FILE \
 && true
