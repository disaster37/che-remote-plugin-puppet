FROM eclipse/che-theia-endpoint-runtime

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

ARG http_proxy
ARG https_proxy

RUN \
    apk add --update --no-cache build-base libffi-dev ruby-dev ruby-full ruby &&\
    gem install pdk puppet &&\
    mkdir -p /home/theia/.config/puppet &&\
    echo "---" > /home/theia/.config/puppet/analytics.yml &&\
    echo "disabled: true" >> /home/theia/.config/puppet/analytics.yml
    


