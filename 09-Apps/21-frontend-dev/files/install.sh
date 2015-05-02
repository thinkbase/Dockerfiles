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

# Install development tools
apt-get install -y build-essential phantomjs

# Install git/svn
apt-get install -y git subversion

# Install nvm, then node.js and others
mkdir -p /opt/gulp-base
cd /opt/gulp-base
git clone https://github.com/creationix/nvm.git
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist
set +e
source /opt/gulp-base/nvm/nvm.sh
nvm install 0.12.2
set -e

# Setting up npm
npm config set prefix /opt/gulp-base/node_global
npm config set cache /opt/gulp-base/node_cache
npm config set registry https://registry.npm.taobao.org

# Install gulp, bower, browserify
npm install -g gulp -verbose
npm install -g bower -verbose
npm install -g browserify -verbose

# Prepare ENV for u01
echo "export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist" >> /home/u01/.bashrc
echo "source /opt/gulp-base/nvm/nvm.sh" >> /home/u01/.bashrc
echo "export PATH=$PATH:/opt/gulp-base/node_global/bin" >> /home/u01/.bashrc
echo "npm config set prefix /workspace/node_global" >> /home/u01/.bashrc
echo "npm config set cache /workspace/node_cache" >> /home/u01/.bashrc
echo "npm config set registry https://registry.npm.taobao.org" >> /home/u01/.bashrc

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# change timezone to Asia/Shanghai
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# finally
rm -rfv /tmp/files
