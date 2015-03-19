#!/bin/bash
set -e
set -x

# Fix the locale
locale-gen en_US en_US.UTF-8 zh_CN zh_CN.UTF-8
dpkg-reconfigure locales

# make sure the package repository is up to date
echo "deb http://cn.archive.ubuntu.com/ubuntu trusty main restricted" > /etc/apt/sources.list
echo "deb http://cn.archive.ubuntu.com/ubuntu trusty-updates main restricted" >> /etc/apt/sources.list
echo "deb http://cn.archive.ubuntu.com/ubuntu trusty universe" >> /etc/apt/sources.list
echo "deb http://cn.archive.ubuntu.com/ubuntu trusty-updates universe" >> /etc/apt/sources.list
echo "deb http://cn.archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list
echo "deb http://cn.archive.ubuntu.com/ubuntu trusty-updates multiverse" >> /etc/apt/sources.list
echo "deb http://cn.archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu trusty-security main restricted" >> /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu trusty-security universe" >> /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu trusty-security multiverse" >> /etc/apt/sources.list
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
