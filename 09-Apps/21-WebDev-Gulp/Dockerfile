# The web-development station, with node.js、npm and gulp, based on ubuntu 14.04
#
# Build this image:
#   docker.io build --force-rm -t webdev-gulp:1.0 .
# Run this image:
#   docker.io run -d -p 12102:22 -p 8888:8888 -v /home/vmware/workspace:/workspace --name gulp webdev-gulp:1.0

FROM ubuntu:14.04-sshd
MAINTAINER thinkbase.net

ADD ./files /tmp/files

# Data volume for trac
VOLUME ["/workspace"]

# Run install script
RUN chmod +x /tmp/files/install.sh
RUN /tmp/files/install.sh

# OpenSSH Server running at port 22, gulp-connect running at port 8888
EXPOSE 22 8888
CMD ["/usr/bin/supervisord"]
