# The basic env of java runtime, with zh-CN support, based on ubuntu 14.04.
#
# Put "start.sh" into /home/u01/workspace then it should start your application when container start.
#
# Build this image:
#   docker build --force-rm -t java-base:1.0 .
# Run this image:
#   docker run -d -p 8080:8080 -v ~/VM_data/docker/java-base:/home/u01/workspace --name java-base java-base:1.0
# Connect to contaainer:
#   docker exec -it java-base bash

FROM ubuntu:14.04-sshd
MAINTAINER thinkbase.net

ADD ./files /tmp/files

# Data volumes
VOLUME ["/home/u01/workspace"]

# Run install script
RUN /tmp/files/install.sh

# export some port used by development
EXPOSE 80 81 443 7001 8080 8443 9080 9443
CMD ["/usr/bin/supervisord"]
