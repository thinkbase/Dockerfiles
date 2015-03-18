#!/bin/bash
set -e
set -x

# make sure the package repository is up to date
apt-get update

# Install dependencies
apt-get install sqlite3
apt-get install build-essential
apt-get install python python-setuptools python-genshi python-subversion
apt-get install python-dev libsqlite3-dev
easy_install pysqlite

# Install git and clone PortableTrac
apt-get install git
mkdir ~/github
cd ~/github
git clone https://github.com/thinkbase/PortableTrac

# Install PortableTrac
~/github/PortableTrac/linux/install$ sudo ./install-PortableTrac.sh

#apt-get install apache2 apache2-utils libapache2-mod-python

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
