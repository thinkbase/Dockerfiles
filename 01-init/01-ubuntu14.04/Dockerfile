# Install openssh-server in ubuntu 14.04
#    For initiation, you should remain it's tag "ubuntu:14.04", then every image based
#    on ubuntu 14.04 should build from local image instead of global registry
#
# Build this image:
#   docker.io build --rm -t ubuntu:1404 .
# Run this image:
#   docker.io stop ubuntu_sshd-vm && sudo docker.io rm ubuntu_sshd-vm
#   docker.io run -d -p 10022:22 --name ubuntu_sshd-vm ubuntu:1404
# Or console only:
#   sudo docker.io run -i -t --name ubuntu_sshd-vm ubuntu:1404 /bin/bash

FROM ubuntu:1404
MAINTAINER thinkbase

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update

# Install openssh server
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Create user "u01", password "docker.io"
RUN useradd -mU -u 1000 -G sudo -d /home/u01 -s /bin/bash u01
RUN echo "u01:docker.io" | chpasswd     # Can't set password properly with "-p" argument in "useradd" command

# OpenSSH Server running at port 22
EXPOSE 22
#CMD /usr/sbin/sshd -D
ENTRYPOINT ["/usr/sbin/sshd", "-D"]