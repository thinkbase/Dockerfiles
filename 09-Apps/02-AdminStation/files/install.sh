#!/bin/bash
set -e
set -x

# Fix the locale
locale-gen en_US en_US.UTF-8 zh_CN zh_CN.UTF-8
dpkg-reconfigure locales

# make sure the package repository is up to date
apt-get update

# Install utilities
apt-get install -y nano telnet

# Install git/svn
apt-get install -y git subversion

# Install dependencies
apt-get install -y build-essential
apt-get install -y python python-setuptools

# Install apache
apt-get install -y apache2 apache2-utils
a2enmod auth_digest
a2enmod authnz_ldap

# Install java, and Chinese font
apt-get install -y default-jre
apt-get install -y ttf-wqy-microhei

# Deploy apache conf
mv /etc/apache2/ports.conf /etc/apache2/ports.conf.orig
cp /tmp/files/ports.conf /etc/apache2/ports.conf
a2dissite 000-default
cp /tmp/files/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# Make u01 and www-data the same group
usermod u01 -aG www-data
usermod www-data -aG u01

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# change timezone to Asia/Shanghai
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# finally
rm -rfv /tmp/files
