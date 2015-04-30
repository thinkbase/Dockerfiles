# Install trac / apache in ubuntu 14.04
#
# Build this image:
#   docker.io build --rm -t trac:1.1 .
# Run this image:
#   docker.io run -d -p 10222:22 -p 8080:8080 -v /home/vmware/trac-data:/data --name trac trac:1.1

FROM ubuntu:14.04-sshd
MAINTAINER thinkbase.net

ADD ./files /tmp/files

# Data volume for trac
VOLUME ["/data"]

# Run install script
RUN chmod +x /tmp/files/install.sh
RUN /tmp/files/install.sh

# OpenSSH Server running at port 22, Trac running at port 8080
EXPOSE 22 8080
CMD ["/usr/bin/supervisord"]
