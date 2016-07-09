# Build thinkbase.net trac server
# Build this image:
#   docker build --force-rm -t trac-thinkbase.net:1.0 .
#
# Run this image:
#   docker run -d -p 8080:8080 -v ~/private:/private --name trac-tk trac-thinkbase.net:1.0

FROM ubuntu:14.04-sshd
MAINTAINER thinkbase.net

# Private files, such as backup then push to github
VOLUME ["/private"]

ADD ./files /tmp/files

# Run install script
RUN chmod +x /tmp/files/install.sh
RUN /tmp/files/install.sh

EXPOSE 22 8080
CMD ["/usr/bin/supervisord"]
