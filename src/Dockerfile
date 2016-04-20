#
# Docker file for running Diladele Web Safety in one container
#
FROM ubuntu:trusty

MAINTAINER support@diladele.com

# set configuration variables
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV DDWS_VER 4.4.0.C405

# install python libs and apache with modwsgi
RUN apt-get update && apt-get install -y \	
	apache2 \
	libapache2-mod-wsgi \
	mc \
	python-ldap	\
	python-setuptools \
	sqlite \
	supervisor \
	wget && \
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
RUN wget http://packages.diladele.com/qlproxy/${DDWS_VER}/amd64/release/ubuntu14/qlproxy-${DDWS_VER}_amd64.deb && \
	dpkg --install qlproxy-${DDWS_VER}_amd64.deb && \
	rm -f qlproxy-${DDWS_VER}_amd64.deb && \
	a2ensite qlproxy && \
	mkdir -p /var/log/qlproxy

# reinitialize squid
RUN /usr/lib/squid3/ssl_crtd -c -s /var/spool/squid_ssldb && \
	chown -R proxy:proxy /var/spool/squid_ssldb

# copy required files
COPY contents/squid.conf /etc/squid/squid.conf
COPY contents/settings.ubuntu14.json /opt/qlproxy/etc/settings.ubuntu14.json
COPY contents/qlproxy /opt/qlproxy/bin/start_qlproxy
COPY contents/wsmgr /opt/qlproxy/bin/start_wsmgr
COPY contents/squid /opt/qlproxy/bin/start_squid
COPY contents/reload.sh /opt/qlproxy/bin/reload.sh
COPY contents/restart.sh /opt/qlproxy/bin/restart.sh
COPY contents/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# reset owner of installation path
RUN chown -R qlproxy:qlproxy /opt/qlproxy && \
    chmod +x /opt/qlproxy/bin/*

# and clear the image
RUN rm -rf /var/lib/apt/lists/*

# assign volumes
VOLUME ["/opt/qlproxy/etc"]
VOLUME ["/etc/squid"]
VOLUME ["/var/spool/squid"]

EXPOSE 80 3128

# and run supervisor
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
