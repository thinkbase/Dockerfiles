#!/bin/bash
set -e
set -x

# make sure the package repository is up to date
apt-get update

# Install dependencies
apt-get install -y sqlite3
apt-get install -y build-essential
apt-get install -y python python-setuptools python-genshi python-subversion
apt-get install -y python-dev libsqlite3-dev
easy_install pysqlite

# Install git and clone PortableTrac
apt-get install -y git
mkdir ~/github
cd ~/github
git clone https://github.com/thinkbase/PortableTrac

# Install PortableTrac
~/github/PortableTrac/linux/install$ sudo ./install-PortableTrac.sh

#apt-get install -y apache2 apache2-utils libapache2-mod-python

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
