FROM eclipse/che-theia-endpoint-runtime:7.0.0-next

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

ARG http_proxy
ARG https_proxy

ENV \
    USER=user \
    GROUP=user \
    USER_ID=1724 \
    GROUP_ID=1724

# Install puppet and PDK
RUN \
    apk add --update --no-cache build-base libffi-dev ruby-dev ruby-full ruby ruby-nokogiri git &&\
    gem install pdk puppet puppet-validator puppet-lint &&\
    cd /tmp &&\
    mkdir -p /home/theia/.config/puppet &&\
    echo "---" > /home/theia/.config/puppet/analytics.yml &&\
    echo "disabled: true" >> /home/theia/.config/puppet/analytics.yml

# Create default user for che
RUN \
    addgroup -g ${GROUP_ID} ${GROUP} &&\
    adduser -s /bin/sh -G ${GROUP} -D -u ${USER_ID} ${USER}

WORKDIR /projects
