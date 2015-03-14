# Install openssh-server in ubuntu 14.04
#
# Build this image:
#   docker.io build --rm -t ubuntu:14.04-sshd .
# Run this image:
#   docker.io stop ubuntu_sshd && docker.io rm ubuntu_sshd
#   docker.io run -d -p 10022:22 --name ubuntu_sshd ubuntu:14.04-sshd
# Or console only:
#   docker.io run -i -t --name ubuntu_sshd ubuntu:14.04-sshd /bin/bash

FROM ubuntu:14.04
MAINTAINER thinkbase.net

ADD ./files /tmp/files
RUN ./tmp/files/install.sh

# OpenSSH Server running at port 22
EXPOSE 22
ENTRYPOINT ["/usr/bin/supervisord"]

