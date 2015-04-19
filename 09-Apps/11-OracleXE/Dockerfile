# Install oracle 11g XE in ubuntu 14.04/x64
# Build this image:
#   docker.io build --rm -t oraclexe:1.0 .
#
# Run this image:
#   mkdir -p ~/VM_data/docker/oradata
#   docker.io run -d -p 11022:22 -p 11521:1521 -v ~/VM_data/docker/oradata:/u01/oradata --name oraclexe oraclexe:1.0
#
# The default password of SYSTEM and SYS is "changeme"(defined in install.sh);
# SQL to chenge their password:
#   alter user system identified by <new_password>;
#   alter user sys identified by <new_password>;

# Ref: https://github.com/mproch/docker-oracle-xe

#FROM ubuntu
FROM ubuntu:14.04-sshd

#MAINTAINER mpr@touk.pl
MAINTAINER thinkbase.net

ENV ORACLE_SID XE

ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe

ADD ./files /tmp/filesOracle

VOLUME ["/u01/oradata"]
RUN ./tmp/filesOracle/install.sh

EXPOSE 22 1521
CMD ["/usr/bin/supervisord"]
