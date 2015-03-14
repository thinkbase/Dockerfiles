#!/bin/bash
set -e
set -x

# make sure the package repository is up to date
echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
apt-get update

# Install openssh server
apt-get install -y openssh-server
mkdir /var/run/sshd

# Create user "u01", password "docker.io"
useradd -mU -u 1000 -G sudo -d /home/u01 -s /bin/bash u01
echo "u01:docker.io" | chpasswd     # Can't set password properly with "-p" argument in "useradd" command

# install supervisor
apt-get install -y supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
