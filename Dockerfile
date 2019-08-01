FROM wsskeleton/theia-endpoint-runtime

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

ARG http_proxy
ARG https_proxy

RUN \
    apk add --update --no-cache build-base libffi-dev ruby-dev ruby-full ruby &&\
    gem install pdk


