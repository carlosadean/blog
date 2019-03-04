FROM centos:latest
LABEL maintainer="carlosadean@gmail.com"

# Prepare os base to install bludit dependencies
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y --setopt=tsflags=nodocs install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum -y --setopt=tsflags=nodocs install wget yum-utils

RUN yum-config-manager --enable remi-php73

# Download gpg keys
RUN wget -q https://archive.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 && \
    wget -q https://rpms.remirepo.net/RPM-GPG-KEY-remi

# Import gpg keys
RUN rpm --import RPM-GPG-KEY-EPEL-7 && \
    rpm --import RPM-GPG-KEY-remi

# install bludit dependencies 
RUN yum -y --setopt=tsflags=nodocs install \
	httpd \
	httpd-tools \
	php \
	php-xml \
	php-json \
	php-gd \
	php-mbstring \
	git

# clean local packages and enable httpd
RUN yum clean all
RUN systemctl enable httpd.service

# create document root directory
RUN mkdir -p /srv/carlosadean.eti.br
RUN cd /srv/carlosadean.eti.br && git clone https://github.com/bludit/bludit.git
RUN sed -i -- 's=\# RewriteBase \/=RewriteBase \/=g' /srv/carlosadean.eti.br/bludit/.htaccess

# copy vhost conf and index.php test files
COPY carlosadean.eti.br.conf /etc/httpd/conf.d/
#COPY index.php /srv/bludit/

# create volume to persist data
VOLUME /srv/data

# set permissions
RUN usermod -u 1001 apache
RUN groupmod -g 1001 apache
RUN chown apache.apache -R /srv/carlosadean.eti.br/bludit
RUN chown apache.apache /var/lib/php/session
#CMD ["/usr/bin/chown", "-R", "apache.apache", "/srv/carlosadean.eti.br"]

# Opening por 80
EXPOSE 80

# https://stackoverflow.com/questions/41318625/start-a-service-inside-docker-centos-7-container
# docker run -it --name bludit -p 80:80 -v /srv/data:/srv/carlosadean.eti.br/bludit/bl-content -e "container=docker" --privileged=true -d --security-opt seccomp:unconfined --cap-add=SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro carlosadean/bludit bash -c "/usr/sbin/init"
