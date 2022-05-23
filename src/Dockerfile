#
# Docker file for running Diladele Web Safety in one container
#
FROM phusion/baseimage:master-amd64

MAINTAINER support@diladele.com

# set configuration variables
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV DDWS_VER 8.1.0.8A10
ENV DDWS_UI_VER 8.1.0.442D
ENV OSNAME "ubuntu20"
ENV WEBSAFETY_IN_DOCKER "True"

# install python libs and apache with modwsgi
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y --no-install-recommends apt-utils \
    apache2 libapache2-mod-wsgi-py3 iproute2 \
    python3-pip python3-dev python3-setuptools \
    sudo curl gnupg libsasl2-dev libldap2-dev libssl-dev g++ \
    krb5-user \
    sqlite && \
    a2dissite 000-default && a2enmod ssl && \
    curl https://packages.diladele.com/diladele_pub.asc -s -o diladele_pub.asc && \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add diladele_pub.asc && rm diladele_pub.asc && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip3 install --upgrade pip && \
    pip3 install wheel && \
    python3 -m pip install \
         django==3.1.7 \
         pytz \
         requests \
         pandas \
         PyYAML \
         psutil \
         tld \
         jinja2 \
         msal pyOpenSSL && \
    pip3 uninstall ldap ldap3 python-ldap || true && \
    pip3 install python-ldap


RUN echo "deb https://squid55.diladele.com/ubuntu/ focal main" > /etc/apt/sources.list.d/squid55.diladele.com.list && \
    apt-get update && apt-get install -y --no-install-recommends \
            libecap3 libecap3-dev \
            squid-common \
            squid-openssl \
            squidclient && \
    rm -rf /var/run/squid.pid && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# get latest web safety and install it
RUN curl https://packages.diladele.com/websafety-core/${DDWS_VER}/amd64/release/${OSNAME}/websafety-${DDWS_VER}_amd64.deb -o websafety-core${DDWS_VER}_amd64.deb && \
    curl https://packages.diladele.com/websafety-ui/${DDWS_UI_VER}/amd64/release/${OSNAME}/websafety-ui-${DDWS_UI_VER}_amd64.deb -o websafety-ui-${DDWS_UI_VER}_amd64.deb && \
    dpkg --install websafety-core${DDWS_VER}_amd64.deb && \
    dpkg --install websafety-ui-${DDWS_UI_VER}_amd64.deb && \
    chown -R proxy:proxy /opt/websafety && \
    chown -R websafety:websafety /opt/websafety-ui && \
    rm -f websafety-core${DDWS_VER}_amd64.deb && \
    rm -f websafety-ui-${DDWS_UI_VER}_amd64.deb && \
    a2ensite websafety && \
    mkdir -p /var/run/apache2 && \
    mkdir -p /var/log/websafety && \
    sudo -u proxy python3 /opt/websafety-ui/var/console/generate.py --core && \
    sudo -u websafety python3 /opt/websafety-ui/var/console/generate.py --ui && \
    chown -R websafety:websafety /opt/websafety-ui && \
    touch /etc/crontab && mkdir -p /opt/websafety/var/reports

RUN echo "websafety ALL=(root) NOPASSWD: /opt/websafety/bin/reload.sh, /opt/websafety/bin/restart.sh, /opt/websafety/bin/cluster.sh, /opt/websafety-ui/bin/certmgr.py, /opt/websafety-ui/bin/cachemgr.py, /usr/bin/tail, /opt/websafety-ui/bin/timezone.py, /opt/websafety-ui/bin/hostname.py, /opt/websafety-ui/bin/resolve.py, /opt/websafety-ui/bin/netmgr.py, /opt/websafety-ui/bin/fsmgr.py, /opt/websafety-ui/bin/cronmgr.py, /opt/websafety-ui/bin/logrotatemgr.py, /opt/websafety-ui/bin/confmgr.py" >> /etc/sudoers

# copy required files
COPY contents/squid.conf /etc/squid/squid.conf
COPY contents/websafety_update /etc/cron.daily
COPY contents/websafety_license /etc/cron.daily
COPY contents/wsicapd /etc/service/wsicapd/run
COPY contents/wsgsbd /etc/service/wsgsbd/run
COPY contents/wsytgd /etc/service/wsytgd/run
COPY contents/wssyncd /etc/service/wssyncd/run
COPY contents/wsmond /etc/service/wsmond/run
COPY contents/squid /etc/service/squid/run
COPY contents/apache2 /etc/service/apache2/run
COPY contents/reload.sh /opt/websafety/bin/reload.sh
COPY contents/restart.sh /opt/websafety/bin/restart.sh
COPY contents/license.pem /opt/websafety/etc/license.pem

# reset owner of installation path
RUN chmod +x /opt/websafety/bin/* && \
    chmod +x /etc/cron.daily/websafety_update && \
    chmod u+s /opt/websafety/bin/* && \
    chmod +x /etc/service/squid/run \
             /etc/service/wsicapd/run \
             /etc/service/wsgsbd/run \
             /etc/service/wsytgd/run \
             /etc/service/wsmond/run \
             /etc/service/apache2/run

# assign volumes
VOLUME ["/opt/websafety/etc"]
VOLUME ["/opt/websafety/var/spool"]
VOLUME ["/opt/websafety/var/console"]
VOLUME ["/opt/websafety/var/db"]
VOLUME ["/opt/websafety/var/log"]
VOLUME ["/opt/websafety/var/reports"]
VOLUME ["/etc/squid"]
VOLUME ["/var/spool"]
VOLUME ["/var/log/squid"]

CMD ["/sbin/my_init"]
