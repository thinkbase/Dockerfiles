# The workstation for administrators, based on ubuntu 14.04
#
# Build this image:
#   docker.io build --rm -t admin:1.0 .
# Run this image:
#   docker.io run -d -p 10902:22 -p 8081:8080 -v /home/vmware/admin-data:/data --name admin admin:1.0

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
