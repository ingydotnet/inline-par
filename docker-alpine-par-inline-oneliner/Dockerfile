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
        Inline \
        Inline::C \
        PAR::Packer \
 && true

WORKDIR /build

RUN pp -e 'use Inline C=>q{void greet(){printf("Hello, Inline\n");}};greet' \
 && mv a.out $EXEC_FILE \
 && true
