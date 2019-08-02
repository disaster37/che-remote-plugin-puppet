FROM eclipse/che-theia-endpoint-runtime:7.0.0-next

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

ARG http_proxy
ARG https_proxy

RUN \
    apk add --update --no-cache build-base libffi-dev ruby-dev ruby-full ruby ruby-nokogiri git &&\
    gem install pdk puppet puppet_facts puppet-validator puppet-lint hiera-puppet &&\
    cd /tmp &&\
    git clone https://github.com/puppetlabs/puppet &&\
    cd puppet &&\
    ./install.rb --bindir=/opt/puppetlabs/puppet/bin --configdir=/etc/puppetlabs/puppet --sitelibdir=/usr/lib/ruby/vendor_ruby --codedir=/et
c/puppetlabs/code --vardir=/opt/puppetlabs/puppet/cache --logdir=/var/log/puppetlabs/puppet --rundir=/var/run/puppetlabs --quick &&\
    ln -s /usr/lib/ruby/gems/2.5.0/gems/hiera-3.5.0/bin/hiera /opt/puppetlabs/puppet/bin/ &&\
    export PATH="/opt/puppetlabs/bin:$PATH" &&\
    puppet config set confdir /etc/puppetlabs/puppet && \
    puppet config set codedir /etc/puppetlabs/code && \
    puppet config set vardir /opt/puppetlabs/puppet/cache && \
    puppet config set logdir /var/log/puppetlabs/puppet && \
    puppet config set rundir /var/run/puppetlabs &&\
    mkdir -p /etc/puppetlabs/code/environment/production && \
    puppet module install puppetlabs-augeas_core && \
    puppet module install puppetlabs-cron_core && \
    puppet module install puppetlabs-host_core && \
    puppet module install puppetlabs-mount_core && \
    puppet module install puppetlabs-scheduled_task && \
    puppet module install puppetlabs-selinux_core && \
    puppet module install puppetlabs-sshkeys_core && \
    puppet module install puppetlabs-yumrepo_core && \
    puppet module install puppetlabs-zfs_core && \
    puppet module install puppetlabs-zone_core && \
    puppet module install puppetlabs-apk &&\
    mkdir -p /home/theia/.config/puppet &&\
    echo "---" > /home/theia/.config/puppet/analytics.yml &&\
    echo "disabled: true" >> /home/theia/.config/puppet/analytics.yml

ENV PATH="/opt/puppetlabs/bin:$PATH"
