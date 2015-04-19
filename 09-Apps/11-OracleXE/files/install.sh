#install all necessary packages
apt-get update
apt-get -y install libaio1 net-tools bc nano

cd /tmp/filesOracle

#resolve some stupid link conflits
ln -s /usr/bin/awk /bin/awk
mkdir /var/lock/subsys
cp chkconfig /sbin/chkconfig
chmod 755 /sbin/chkconfig
ln -s /proc/mounts /etc/mtab

cat /tmp/filesOracle/oracle-xe_11.2.0-2_amd64.deb-splited/oracle-xe_11.2.0-2_amd64.deb-splited.* > /tmp/filesOracle/oracle-xe_11.2.0-2_amd64.deb
dpkg --install /tmp/filesOracle/oracle-xe_11.2.0-2_amd64.deb

#change memory_target
cp init.ora $ORACLE_HOME/config/scripts
cp initXETemp.ora $ORACLE_HOME/config/scripts

#final configuration(SYSTEM/SYS's password is "changeme")
/usr/bin/printf 8080\\n1521\\nchangeme\\nchangeme\\ny\\n | /etc/init.d/oracle-xe configure

#prepare start up shell scripts
cp createListener.sh /
cp createTnsnames.sh /
cp start-oracle-xe.sh /
chmod +x /*.sh

#change system env
echo "ORACLE_HOME=\"$ORACLE_HOME\"
ORACLE_SID=\"$ORACLE_SID\"
PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$ORACLE_HOME/bin\"
" > /etc/environment

#change oracle's env
echo "ORACLE_HOME=\"$ORACLE_HOME\"
ORACLE_SID=\"$ORACLE_SID\"
PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$ORACLE_HOME/bin\"
" > /u01/app/oracle/.profile

# install supervisor
apt-get install -y supervisor
cp supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#clean up
cd /tmp
rm -rfv /tmp/filesOracle

