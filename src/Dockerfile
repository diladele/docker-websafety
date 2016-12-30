#
# Docker file for running Diladele Web Safety in one container
#
FROM phusion/baseimage:0.9.19

MAINTAINER support@diladele.com

# set configuration variables
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV DDWS_VER 4.8.0.935B

# install python libs and apache with modwsgi
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
            apache2 \
            libapache2-mod-wsgi \
            python-ldap	\
            sudo \
            sqlite && \
    a2dissite 000-default && \
    curl http://packages.diladele.com/diladele_pub.asc -o diladele_pub.asc && apt-key add diladele_pub.asc && rm diladele_pub.asc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends python-pip && \
    pip install --upgrade pip && \
    pip install django==1.6.11 && \
    apt-get remove -y --auto-remove python-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "deb http://ubuntu16.diladele.com/ubuntu/ xenial main" > /etc/apt/sources.list.d/ubuntu16.diladele.com.list && \
    apt-get update && apt-get install -y --no-install-recommends \
            libecap3 \
            squid-common \
            squid \
            squidclient && \
    rm -rf /var/run/squid.pid && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# get latest web safety and install it
RUN curl http://packages.diladele.com/qlproxy/${DDWS_VER}/amd64/release/ubuntu16/qlproxy-${DDWS_VER}_amd64.deb -o qlproxy-${DDWS_VER}_amd64.deb  && \
	dpkg --install qlproxy-${DDWS_VER}_amd64.deb && \
	rm -f qlproxy-${DDWS_VER}_amd64.deb && \
	a2ensite qlproxy && \
	mkdir -p /var/log/qlproxy

# too many hardlinks in phusion-basimage for crontab
RUN touch /etc/crontab

# make runit service directories
RUN mkdir /etc/service/squid /etc/service/apache2 /etc/service/qlproxy /etc/service/wsmgr

# copy required files
COPY contents/qlproxy /etc/service/qlproxy/run
COPY contents/wsmgr /etc/service/wsmgr/run
COPY contents/squid /etc/service/squid/run
COPY contents/apache2 /etc/service/apache2/run
COPY contents/reload.sh /opt/qlproxy/bin/reload.sh
COPY contents/restart.sh /opt/qlproxy/bin/restart.sh
COPY contents/system.json /opt/qlproxy/etc/system.json
COPY contents/license.pem /opt/qlproxy/etc/license.pem
COPY contents/firstrun.sh /usr/local/bin/firstrun.sh

# reset owner of installation path
RUN chown -R qlproxy:qlproxy /opt/qlproxy && \
    chmod +x /opt/qlproxy/bin/* && \
    chmod +x /usr/local/bin/firstrun.sh && \
    chmod u+s /opt/qlproxy/bin/* && \
    chmod 755 /opt/qlproxy/bin/certmgr && \
    chmod +x /etc/service/squid/run \
		/etc/service/wsmgr/run \
		/etc/service/qlproxy/run \
		/etc/service/apache2/run

# assign volumes
VOLUME ["/opt/qlproxy/etc"]
VOLUME ["/opt/qlproxy/var/spool"]
VOLUME ["/opt/qlproxy/var/console/console"]
VOLUME ["/opt/qlproxy/var/db"]
VOLUME ["/opt/qlproxy/var/log"]
VOLUME ["/opt/qlproxy/var/reports"]
VOLUME ["/etc/squid"]
VOLUME ["/var/spool"]
VOLUME ["/var/log/squid"]

CMD ["/sbin/my_init"]
