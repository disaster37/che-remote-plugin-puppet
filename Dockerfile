FROM centos:8

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

ARG http_proxy
ARG https_proxy

ENV HOME=/home/theia

# Require for CHE
# Change permissions to let any arbitrary user
RUN mkdir /projects ${HOME} && \
    for f in "${HOME}" "/etc/passwd" "/projects"; do \
      echo "Changing permissions on ${f}" && chgrp -R 0 ${f} && \
      chmod -R g+rwX ${f}; \
    done
ADD etc/entrypoint.sh /entrypoint.sh


# Install puppet and PDK
RUN \
    rpm -Uvh https://yum.puppet.com/puppet6-release-el-8.noarch.rpm &&\
    yum install -y pdk git puppet-agent sudo &&\
    /opt/puppetlabs/puppet/bin/gem install puppet-lint &&\
    yum clean all &&\
    mkdir -p /home/theia/.config/puppet &&\
    echo "---" > /home/theia/.config/puppet/analytics.yml &&\
    echo "disabled: true" >> /home/theia/.config/puppet/analytics.yml




ENTRYPOINT [ "/entrypoint.sh" ]
CMD ${PLUGIN_REMOTE_ENDPOINT_EXECUTABLE}
