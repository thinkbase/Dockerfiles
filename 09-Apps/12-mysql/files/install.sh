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

# Install mysql
export DEBIAN_FRONTEND=noninteractive
sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d
echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
apt-get install -y mysql-server

# Prepare mysql config and starter
cp /tmp/files/my.cnf /etc/mysql/my.cnf
cp /tmp/files/start-mysql.sh /home/u01/start-mysql.sh
chmod +x /home/u01/start-mysql.sh
chown u01:u01 /home/u01/start-mysql.sh

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# change timezone to Asia/Shanghai
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# finally
rm -rfv /tmp/files
