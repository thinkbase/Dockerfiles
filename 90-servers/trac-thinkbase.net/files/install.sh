#!/bin/bash
set -e
set -x

# Fix the locale
locale-gen en_US en_US.UTF-8 zh_CN zh_CN.UTF-8
dpkg-reconfigure locales

# make sure the package repository is up to date
apt-get update

# Install utilities
apt-get install -y --force-yes nano telnet

# Install git/svn and clone PortableTrac
apt-get install -y --force-yes git subversion

# Prepare github repo's folder
su u01 -c "mkdir -p /home/u01/github"

# Clone PortableTrac and AdminShells
cd /home/u01/github
su u01 -c "git clone -v --progress https://github.com/thinkbase/PortableTrac"
su u01 -c "git clone -v --progress https://github.com/thinkbase/AdminShells"

# Install dependencies
apt-get install -y --force-yes sqlite3
apt-get install -y --force-yes build-essential
apt-get install -y --force-yes python python-setuptools python-genshi python-subversion
apt-get install -y --force-yes python-dev libsqlite3-dev
easy_install pysqlite

# Install PortableTrac
cd /home/u01/github/PortableTrac/linux/install
chmod +x ./install-PortableTrac.sh
./install-PortableTrac.sh

# Install apache
apt-get install -y --force-yes apache2 apache2-utils libapache2-mod-python
a2enmod auth_digest
a2enmod authnz_ldap
apt-get install -y --force-yes libapache2-svn

# Install graphviz, java, and Chinese font
apt-get install -y --force-yes graphviz
apt-get install -y --force-yes default-jre
apt-get install -y --force-yes ttf-wqy-microhei

# Deploy apache conf for trac
mv /etc/apache2/ports.conf /etc/apache2/ports.conf.orig
cp /tmp/files/ports.conf /etc/apache2/ports.conf
a2dissite 000-default
cp /tmp/files/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# Make u01 and www-data the same group
usermod u01 -aG www-data
usermod www-data -aG u01

# Checkout the thinkbase.net site
mkdir -p /data/trac
git clone -v --progress https://github.com/thinkbase/trac-thinkbase.net.git /data/trac
cd /data/trac
./restore.sh
chmod g+Xw -Rv /data/trac
chown u01:u01 -Rv /data/trac

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# change timezone to Asia/Shanghai
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# finally
rm -rfv /tmp/files
