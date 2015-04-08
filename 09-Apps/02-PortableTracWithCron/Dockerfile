# Install cron support based on 01-PortableTrac in ubuntu 14.04
#
# Build this image:
#   docker.io build --rm -t trac-with-cron:1.0 .
# Run this image:
#   docker.io run -d -p 10222:22 -p 8080:8080 -v /home/vmware/trac-data:/data --name trac trac-with-cron:1.0

FROM trac:1.0
MAINTAINER thinkbase.net

ADD ./files /tmp/files

# Data volume for trac and cron
VOLUME ["/data"]

# Run install script
RUN chmod +x /tmp/files/install.sh
RUN /tmp/files/install.sh

# OpenSSH Server running at port 22, Trac running at port 8080
EXPOSE 22 8080
CMD ["/usr/bin/supervisord"]
