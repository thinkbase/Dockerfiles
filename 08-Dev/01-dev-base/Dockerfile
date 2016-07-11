# The basic env of development workstation, with X11/nodejs/firefox + zh-CN support, based on ubuntu 14.04
#
# Build this image:
#   docker build --force-rm -t dev-base:1.0 .
# Run this image:
#   docker run -d -p 8080:8080 -v /tmp/.X11-unix:/tmp/.X11-unix --name dev-base dev-base:1.0
# Connect to contaainer:
#   docker exec -it dev-base bash

FROM ubuntu:14.04-sshd
MAINTAINER thinkbase.net

ADD ./files /tmp/files

# Data volumes
VOLUME ["/home/u01/workspace", "/tmp/.X11-unix"]

# Run install script
RUN /tmp/files/install.sh

# export some port used by development
EXPOSE 80 81 443 7001 8080 8443 9080 9443
CMD ["/usr/bin/supervisord"]
