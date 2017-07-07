#
# Postil: Dockerfile for building MariaDB images
#

FROM            docker.io/centos:latest
MAINTAINER      Renyf <renyongfanemail@sina.com>

ENV DATA_DIR /var/lib/mysql

# Install Mariadb
RUN yum -y install epel-release && \
    yum -y install mariadb mariadb-server && \
    yum clean all

ADD my.cnf /etc/my.cnf
ADD mysqld_charset.cnf /etc/my.cnf.d/mysqld_charset.cnf
RUN chmod 644 /etc/my.cnf.d/mysqld_charset.cnf

COPY scripts /scripts
RUN chmod +x /scripts/*.sh

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

CMD ["/scripts/start.sh"]
