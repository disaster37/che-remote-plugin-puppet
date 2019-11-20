FROM alpine:3.10

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

ARG http_proxy
ARG https_proxy


# Install puppet and PDK
RUN \
    apk add --update --no-cache build-base libffi-dev ruby-dev ruby-full ruby ruby-nokogiri git sudo &&\
    gem install pdk puppet puppet-validator puppet-lint &&\
    cd /tmp &&\
    mkdir -p /home/theia/.config/puppet &&\
    echo "---" > /home/theia/.config/puppet/analytics.yml &&\
    echo "disabled: true" >> /home/theia/.config/puppet/analytics.yml


ADD etc/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ${PLUGIN_REMOTE_ENDPOINT_EXECUTABLE}
