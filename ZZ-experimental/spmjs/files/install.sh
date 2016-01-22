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

# Install nvm, then node.js and others
mkdir -p /opt/nodejs
cd /opt/nodejs
git clone https://github.com/creationix/nvm.git
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist
set +e
source /opt/nodejs/nvm/nvm.sh
nvm install 0.12.4
set -e

# Setting up npm
#npm config set prefix /opt/nodejs/node_global
#npm config set cache /opt/nodejs/node_cache
npm config set registry https://registry.npm.taobao.org

# Prepare ENV for u01
#echo "export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist" >> /home/u01/.bashrc
#echo "source /opt/nodejs/nvm/nvm.sh" >> /home/u01/.bashrc
#echo "export PATH=$PATH:/opt/nodejs/node_global/bin" >> /home/u01/.bashrc
#echo "npm config set registry https://registry.npm.taobao.org" >> /home/u01/.bashrc

# Install nginx (add-apt-repository need software-properties-common/python-software-properties)
apt-get install -y software-properties-common
add-apt-repository -y ppa:nginx/stable
apt-get update
apt-get install -y nginx
rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
ln -sf /dev/stdout /var/log/nginx/access.log
ln -sf /dev/stderr /var/log/nginx/error.log
rm -f /etc/nginx/conf.d/*.conf

export SERVER_NAME="spm.example.com"
cd /opt/
git clone git://github.com/spmjs/spmjs.io.git --depth=1
cd spmjs.io
npm install

cp config/base.default.yaml config/base.yaml

sed -ri "s/^(\s*listen\s+)[0-9]+(;\s*)$/\180\2/" config/nginx.conf
sed -ri "s/^(\s*server_name\s+).+(;\s*)$/\1${SERVER_NAME}\2/" config/nginx.conf
sed -ri "s/^(\s*access_log\s+).+(;\s*)$/\1\/var\/log\/access.log\2/" config/nginx.conf
sed -ri "s/^(\s*error_log\s+).+(;\s*)$/\1\/var\/log\/error.log\2/" config/nginx.conf
ln -sf $(pwd)/config/nginx.conf /etc/nginx/conf.d/spmjs.conf

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# change timezone to Asia/Shanghai
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# finally
rm -rfv /tmp/files
