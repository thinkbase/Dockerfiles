#!/bin/bash
set -e
set -x

# make sure the package repository is up to date
apt-get update

# Fix the locale
locale-gen en_US en_US.UTF-8 zh_CN zh_CN.UTF-8
dpkg-reconfigure locales

# change timezone to Asia/Shanghai
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Install utilities
apt-get install -y --force-yes nano telnet

# Install zh-CN support
apt-get install -y --force-yes language-pack-zh-hans
apt-get install -y --force-yes ttf-ubuntu-font-family
apt-get install -y --force-yes ttf-wqy-zenhei ttf-wqy-microhei

# Install git/svn
apt-get install -y --force-yes git subversion

# Install java
mkdir -p /opt/java
cat /tmp/files/jdk-8u101-linux-x64-splited/jdk-8u101-linux-x64.tar.gz-splited.* > /tmp/files/jdk-8u101-linux-x64.tar.gz
tar xzvf /tmp/files/jdk-8u101-linux-x64.tar.gz -C /opt/java
echo "export JAVA_HOME=/opt/java/jdk1.8.0_101" >> /etc/profile
echo "export PATH=/opt/java/jdk1.8.0_101/bin:$PATH" >> /etc/profile

# Login into u01 directly
echo "su - u01" >> /root/.bashrc

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# finally
rm -rfv /tmp/files
