#
# Docker file for running Diladele Web Safety in one container
#
FROM phusion/baseimage:bionic-1.0.0

MAINTAINER support@diladele.com

# set configuration variables
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV DDWS_VER 7.5.0.0ADC
ENV DDWS_UI_VER 7.5.0.AF41

# install python libs and apache with modwsgi
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y --no-install-recommends apt-utils \
    apache2 libapache2-mod-wsgi-py3 \
    python3-pip python3-dev python3-setuptools \
    sudo curl gnupg libsasl2-dev libldap2-dev libssl-dev g++ \
    krb5-user \
    sqlite && \
    a2dissite 000-default && \
    curl http://packages.diladele.com/diladele_pub.asc -o diladele_pub.asc && apt-key add diladele_pub.asc && rm diladele_pub.asc && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    # the Azure deployment insists on this
    # sed -i 's/ClientAliveInterval 120/ClientAliveInterval 180/g' /etc/ssh/sshd_config && \
    # change cloud config to preserve hostname, otherwise our UI cannot set it
    # sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg && \
    pip3 install wheel && \
    pip3 install \
         django==2.1.2 \
         pytz \
         requests \
         pandas \
         PyYAML \
         pyOpenSSL && \
    pip3 uninstall ldap ldap3 python-ldap || true && \
    pip3 install python-ldap
    #reportlab==3.4.0


RUN echo "deb http://squid413.diladele.com/ubuntu/ bionic main" > /etc/apt/sources.list.d/squid413.diladele.com.list && \
    apt-get update && apt-get install -y --no-install-recommends \
            libecap3 libecap3-dev \
            squid-common \
            squid \
            squidclient && \
    rm -rf /var/run/squid.pid && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# get latest web safety and install it
RUN curl http://packages.diladele.com/websafety-core/${DDWS_VER}/amd64/release/ubuntu18/websafety-${DDWS_VER}_amd64.deb -o websafety-core${DDWS_VER}_amd64.deb && \
    curl http://packages.diladele.com/websafety-ui/${DDWS_UI_VER}/amd64/release/ubuntu18/websafety-ui-${DDWS_UI_VER}_amd64.deb -o websafety-ui-${DDWS_UI_VER}_amd64.deb && \
    dpkg --install websafety-core${DDWS_VER}_amd64.deb && \
    dpkg --install websafety-ui-${DDWS_UI_VER}_amd64.deb && \
    chown -R proxy:proxy /opt/websafety && \
    rm -f websafety-core${DDWS_VER}_amd64.deb && \
    rm -f websafety-ui-${DDWS_UI_VER}_amd64.deb && \
    a2ensite websafety && \
    mkdir -p /var/run/apache2 && \
    mkdir -p /var/log/websafety && \
    sudo -u proxy python3 /opt/websafety-ui/var/console/generate.py --core && \
    sudo -u websafety python3 /opt/websafety-ui/var/console/generate.py --ui && \
    chown -R websafety:websafety /opt/websafety-ui && \
    #sudo -u websafety python3 /opt/websafety-ui/var/console/utils.py --network="ubuntu18" && \
    touch /etc/crontab && mkdir /etc/service/squid /etc/service/apache2 /etc/service/wsicap /etc/service/wsgsb /etc/service/wsytg /opt/websafety/var/reports /etc/service/wssync

# copy required files
COPY contents/squid.conf /etc/squid/squid.conf
COPY contents/websafety_update /etc/cron.daily
COPY contents/wsicap /etc/service/wsicap/run
COPY contents/wsgsb /etc/service/wsgsb/run
COPY contents/wsytg /etc/service/wsytg/run
COPY contents/wssync /etc/service/wssync/run
COPY contents/squid /etc/service/squid/run
COPY contents/apache2 /etc/service/apache2/run
COPY contents/reload.sh /opt/websafety/bin/reload.sh
COPY contents/restart.sh /opt/websafety/bin/restart.sh
COPY contents/license.pem /opt/websafety/etc/license.pem
COPY contents/firstrun.sh /usr/local/bin/firstrun.sh

# reset owner of installation path
RUN chown -R websafety:websafety /opt/websafety && \
    chmod +x /opt/websafety/bin/* && \
    chmod +x /usr/local/bin/firstrun.sh && \
    chmod +x /etc/cron.daily/websafety_update && \
    chmod u+s /opt/websafety/bin/* && \
    chmod +x /etc/service/squid/run \
             /etc/service/wsicap/run \
             /etc/service/wsgsb/run \
             /etc/service/wsytg/run \
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
