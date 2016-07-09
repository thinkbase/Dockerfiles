# Install openssh-server in ubuntu 14.04
#
# Build this image:
#   docker.io build --force-rm -t ubuntu:14.04-sshd .
# Run this image:
#   docker.io run -d -p 10022:22 --name ubuntu_sshd ubuntu:14.04-sshd
# Or console only:
#   docker.io run -i -t --name ubuntu_sshd ubuntu:14.04-sshd /bin/bash

FROM ubuntu:14.04
MAINTAINER thinkbase.net

ADD ./files /tmp/files

RUN chmod +x /tmp/files/install.sh
RUN /tmp/files/install.sh

# OpenSSH Server running at port 22
EXPOSE 22
CMD ["/usr/bin/supervisord"]
