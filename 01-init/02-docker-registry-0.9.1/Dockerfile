# Image with docker-registry project and dependecies
#
# Build this image:
#   docker.io build -rm -t docker-registry:0.9.1 .
# Run this image:
#   docker.io run -d -p 5000:5000 -p 10122:22 -v /home/vmware/docker-registry-data:/data -name docker-registry docker-registry:0.9.1
#
# *****************************************************************************
# From: https://github.com/docker/docker-registry/blob/0.9.1/Dockerfile
# *****************************************************************************
# VERSION 0.1
# DOCKER-VERSION  0.7.3
# AUTHOR:         Sam Alba <sam@docker.com>
# DESCRIPTION:    Image with docker-registry project and dependecies
# TO_BUILD: docker build -rm -t registry .
# TO_RUN: docker run -p 5000:5000 registry

# Latest Ubuntu LTS
##FROM ubuntu:14.04
FROM ubuntu:14.04-sshd

# Update
RUN apt-get update \
# Install pip
    && apt-get install -y \
        swig \
        python-pip \
# Install deps for backports.lmza (python2 requires it)
        python-dev \
        libssl-dev \
        liblzma-dev \
        libevent1-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . /docker-registry
COPY ./config/boto.cfg /etc/boto.cfg

# Install core
RUN pip install /docker-registry/depends/docker-registry-core

# Install registry
RUN pip install file:///docker-registry#egg=docker-registry[bugsnag,newrelic,cors]

RUN patch \
 $(python -c 'import boto; import os; print os.path.dirname(boto.__file__)')/connection.py \
 < /docker-registry/contrib/boto_header_patch.diff

ENV DOCKER_REGISTRY_CONFIG /docker-registry/config/config.yml
ENV SETTINGS_FLAVOR prod

RUN cp /docker-registry/supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
VOLUME ["/data"]
EXPOSE 22 5000
CMD ["/usr/bin/supervisord"]
