#
# Docker file for running Diladele Web Safety in one container
#
FROM ubuntu:trusty

MAINTAINER support@diladele.com

# set configuration variables
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV DDWS_VER 4.5.0.7470

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

# the latest squid 3.5 exists for unknown reasons after start, so we will rebuild squid 3.3.8 from ubuntu
COPY rules.patch .
COPY gadgets.cc.sha256.patch .
COPY gadgets.cc.firefox.patch .

# do the build
RUN apt-get install -y \
	devscripts \
	build-essential \
	fakeroot \
	libssl-dev && \
	apt-get source squid3 && apt-get -y build-dep squid3 && \
	patch squid3-3.3.8/debian/rules < rules.patch && \
	patch squid3-3.3.8/src/ssl/gadgets.cc < gadgets.cc.sha256.patch && \
	patch squid3-3.3.8/src/ssl/gadgets.cc < gadgets.cc.firefox.patch && \
	cd squid3-3.3.8 && dpkg-buildpackage -rfakeroot -b

# and install it
RUN apt-get -y install \
	ssl-cert \
	squid-langpack && \
	dpkg --install squid3-common_3.3.8-1ubuntu6.*_all.deb && \
	dpkg --install squid3_3.3.8-1ubuntu6.*_amd64.deb && \
	dpkg --install squidclient_3.3.8-1ubuntu6.*_amd64.deb

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
VOLUME ["/etc/squid3"]
VOLUME ["/var/spool/squid3"]

EXPOSE 80 3128

# and run supervisor
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
