#
# Docker file for running Diladele Web Safety in one container
#
FROM phusion/baseimage:0.11

MAINTAINER support@diladele.com

# set configuration variables
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV DDWS_VER 7.0.0.7A5E

# install python libs and apache with modwsgi
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
            apache2 libapache2-mod-wsgi-py3 \
            python3-pip python3-dev python3-setuptools \
            sudo curl gnupg sqlite htop mc \
            libsasl2-dev libldap2-dev libssl-dev g++ \
            krb5-user \
            sqlite && \
    a2dissite 000-default && \
    curl http://packages.diladele.com/diladele_pub.asc -o diladele_pub.asc && apt-key add diladele_pub.asc && rm diladele_pub.asc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install wheel

RUN \ 
    pip3 install \
        django==2.1.2 \
        pytz \
        requests \
        pandas \
        PyYAML \
        pyOpenSSL

RUN pip3 uninstall ldap ldap3 python-ldap || true

RUN pip3 install \
    python-ldap \
    reportlab==3.4.0


RUN echo "deb http://squid46.diladele.com/ubuntu/ bionic main" > /etc/apt/sources.list.d/squid46.diladele.com.list && \
    apt-get update && apt-get install -y --no-install-recommends \
            libecap3 libecap3-dev \
            squid-common \
            squid \
            squidclient && \
    rm -rf /var/run/squid.pid && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# get latest web safety and install it
RUN curl http://packages.diladele.com/websafety/${DDWS_VER}/amd64/release/ubuntu18/websafety-${DDWS_VER}_amd64.deb -o websafety-${DDWS_VER}_amd64.deb  && \
    dpkg --install websafety-${DDWS_VER}_amd64.deb && \
    rm -f websafety-${DDWS_VER}_amd64.deb && \
    a2ensite websafety && \
    mkdir -p /var/run/apache2 && \
    mkdir -p /var/log/websafety && \
    sudo -u websafety python3 /opt/websafety/var/console/generate.py

# too many hardlinks in phusion-basimage for crontab
RUN touch /etc/crontab

# make runit service directories
RUN mkdir /etc/service/squid /etc/service/apache2 /etc/service/wsicap /etc/service/wsmgr /etc/service/wsgsb /etc/service/wsytg /opt/websafety/var/reports

# copy required files
COPY contents/squid.conf /etc/squid/squid.conf
COPY contents/websafety_update /etc/cron.daily
COPY contents/wsicap /etc/service/wsicap/run
COPY contents/wsmgr /etc/service/wsmgr/run
COPY contents/wsgsb /etc/service/wsgsb/run
COPY contents/wsytg /etc/service/wsytg/run
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
    chmod 755 /opt/websafety/bin/certmgr.py && \
    chmod 755 /opt/websafety/bin/report && \
    chmod +x /etc/service/squid/run \
        /etc/service/wsmgr/run \
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
