#
# Docker file for running Diladele Web Safety in one container
#
FROM phusion/baseimage:0.9.15

MAINTAINER junk@nospam.net

# set configuration variables
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV DDWS_VER 4.5.0.7470

# install python libs and apache with modwsgi
RUN apt-get update && apt-get install -y \	
	apache2 \
	libapache2-mod-wsgi \
	python-ldap	\
	python-setuptools \
        python-mysqldb \
	sqlite && \
        a2dissite 000-default

# install django
RUN easy_install django==1.6.11

# add repo for new squid
RUN echo "deb http://ubuntu.diladele.com/ubuntu/ trusty main" > /etc/apt/sources.list.d/ubuntu.diladele.com.list

# install squid
RUN apt-get update && apt-get install -y --allow-unauthenticated \
        libecap3 \
        squid-common \
        squid \
        squidclient

# get latest web safety and install it
RUN curl http://packages.diladele.com/qlproxy/${DDWS_VER}/amd64/release/ubuntu14/qlproxy-${DDWS_VER}_amd64.deb -o qlproxy-${DDWS_VER}_amd64.deb  && \
	dpkg --install qlproxy-${DDWS_VER}_amd64.deb && \
	rm -f qlproxy-${DDWS_VER}_amd64.deb && \
	a2ensite qlproxy && \
	mkdir -p /var/log/qlproxy

# too many hardlinks in phusion-basimage for crontab
RUN touch /etc/crontab

# reinitialize squid
#RUN /usr/lib/squid/ssl_crtd -c -s /var/spool/squid_ssldb && \
#	chown -R proxy:proxy /var/spool/squid_ssldb

# make runit service directories
RUN mkdir /etc/service/squid /etc/service/apache2 /etc/service/qlproxy /etc/service/wsmgr
# copy required files
COPY contents/squid.conf /etc/squid3/squid.conf
COPY contents/qlproxy /etc/service/qlproxy/run
COPY contents/wsmgr /etc/service/wsmgr/run
COPY contents/squid /etc/service/squid/run
COPY contents/apache2 /etc/service/apache2/run
COPY contents/reload.sh /opt/qlproxy/bin/reload.sh
COPY contents/restart.sh /opt/qlproxy/bin/restart.sh
COPY contents/system.json /opt/qlproxy/etc/system.json
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

# and clear the image
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/run/squid.pid /var/run/apache2/apache2.pid

# assign volumes
VOLUME ["/opt/qlproxy/etc"]
VOLUME ["/opt/qlproxy/var/spool"]
VOLUME ["/etc/squid"]
VOLUME ["/var/spool"]

CMD ["/sbin/my_init"]
