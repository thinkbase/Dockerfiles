#!/bin/bash
set -e
set -x

# Fix the locale
locale-gen en_US en_US.UTF-8 zh_CN zh_CN.UTF-8
dpkg-reconfigure locales

# Prepare /data - change Owner to u01
chown -Rv u01:u01 /data

# make sure the package repository is up to date
apt-get update

# Install git and clone PortableTrac
apt-get install -y git
su u01 -c "mkdir -p /home/u01/github"
cd /home/u01/github
su u01 -c "git clone -v --progress https://github.com/thinkbase/PortableTrac"

# Install dependencies
apt-get install -y sqlite3
apt-get install -y build-essential
apt-get install -y python python-setuptools python-genshi python-subversion
apt-get install -y python-dev libsqlite3-dev
easy_install pysqlite

# Install PortableTrac
cd /home/u01/github/PortableTrac/linux/install
chmod +x ./install-PortableTrac.sh
./install-PortableTrac.sh

# Install apache
apt-get install -y apache2 apache2-utils libapache2-mod-python

# Deploy apache conf for trac
cp /tmp/files/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
