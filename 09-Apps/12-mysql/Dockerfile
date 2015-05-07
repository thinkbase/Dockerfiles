# The workstation for administrators, based on ubuntu 14.04
#
# Build this image:
#   docker.io build --rm -t mysql:1.0 .
# Run this image:
#   docker.io run -d -p 12022:22 -p 3306:3306 -v ~/VM_data/docker/mysql:/data --name mysql mysql:1.0
#
# The default password of mysql 'root' is '123456'.

FROM ubuntu:14.04-sshd
MAINTAINER thinkbase.net

ADD ./files /tmp/files

# Data volume for trac
VOLUME ["/data"]

# Run install script
RUN chmod +x /tmp/files/install.sh
RUN /tmp/files/install.sh

# OpenSSH Server running at port 22, MySQL running at port 3306
EXPOSE 22 3306
CMD ["/usr/bin/supervisord"]
