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
apt-get install -y nano telnet

# Install zh-CN support
apt-get install -y language-pack-zh-hans
apt-get install -y ttf-ubuntu-font-family
apt-get install -y ttf-wqy-zenhei ttf-wqy-microhei

# Install development tools
apt-get install -y build-essential

# Install git/svn
apt-get install -y git subversion

# Install openjdk
apt-get -y install openjdk-7-jdk

# Install firefox
apt-get install -y firefox

# Prepare DISPLAY for u01 (NOTE: require "-v /tmp/.X11-unix:/tmp/.X11-unix" when docker "run")
echo "export DISPLAY=\":0\"" >> /home/u01/.bashrc

# Install portable NodeJS
su u01 -c "git clone -v --progress https://github.com/thinkbase/PortableNodeJS.git ~/PortableNodeJS"

su u01 -c "export TERM=\"xterm-256color\" ; ~/PortableNodeJS/scripts/npm -v"

cp /tmp/files/.bashrc-start-node-bash /home/u01
chown u01:u01 /home/u01/.bashrc-start-node-bash
echo "source ~/.bashrc-start-node-bash" >> /home/u01/.bashrc

echo "su - u01" >> /root/.bashrc

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# finally
rm -rfv /tmp/files
