# The basic env of development workstation, with X11/nodejs/firefox + zh-CN support, based on ubuntu 14.04
#
# Build this image:
#   docker.io build --force-rm -t dev-base:1.0 .
# Run this image:
#   docker.io run -d -p 20801:22 -v ~/VM_data/docker/dev-base:/home/u01/workspace -v /tmp/.X11-unix:/tmp/.X11-unix --name dev-base dev-base:1.0

FROM ubuntu:14.04-sshd
MAINTAINER thinkbase.net

ADD ./files /tmp/files

# Data volumes
VOLUME ["/home/u01/workspace", "/tmp/.X11-unix"]

# Run install script
RUN chmod +x /tmp/files/install.sh
RUN /tmp/files/install.sh

# OpenSSH Server running at port 22
EXPOSE 22
CMD ["/usr/bin/supervisord"]
