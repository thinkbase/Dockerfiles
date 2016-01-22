# The frontend development workstation, with node.js、npm and gulp, based on ubuntu 14.04
#
# Build this image:
#   docker.io build --force-rm -t spmjs:1.0 .
# Run this image:
#   docker.io run -d -p 13022:22 -p 8001:80 -v /home/vmware/workspace:/workspace --name spmjs spmjs:1.0

FROM ubuntu:14.04-sshd
MAINTAINER thinkbase.net

ADD ./files /tmp/files

# Data volume for nginx cache
VOLUME ["/var/cache/nginx"]

# Run install script
RUN chmod +x /tmp/files/install.sh
RUN /tmp/files/install.sh

# OpenSSH Server running at port 22, spmjs running at port 80
EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
