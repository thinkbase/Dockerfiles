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
apt-get install -y build-essential phantomjs

# Install git/svn
apt-get install -y git subversion

# Install openjdk
apt-get -y install openjdk-7-jdk

# Install firefox
apt-get install -y firefox

# Prepare DISPLAY for u01 (NOTE: require "-v /tmp/.X11-unix:/tmp/.X11-unix" when docker "run")
echo "export DISPLAY=\":0\"" >> /home/u01/.bashrc

# Install nvm and nodejs
mkdir -p /opt/nvm
cd /opt/nvm
git clone https://github.com/creationix/nvm.git .
chmod -Rv o+rwX /opt/nvm
chmod -Rv g+rwX /opt/nvm
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist
set +e
source /opt/nvm/nvm.sh
nvm install 0.12.2
set -e

# Prepare more profile for u01
echo "export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist" >> /home/u01/.bashrc
echo "source /opt/nvm/nvm.sh" >> /home/u01/.bashrc
echo "nvm use 0.12.2" >> /home/u01/.bashrc
echo "npm config set registry https://registry.npm.taobao.org" >> /home/u01/.bashrc

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# finally
rm -rfv /tmp/files
