#!/bin/bash
set -o nounset
set -o errexit

echo "$(date): Begin to start MySQL service ..."

# If volumn /data/mysql not exist, init mysql database ...
echo "-- nothing" > /tmp/init.sql
if [ ! -d "/data/mysql" ]
then
    mkdir -p /data/mysql/db
	mkdir -p /data/mysql/mysqld
	/usr/bin/mysql_install_db
	chown -Rv u01:u01 /data/mysql
	# Prepare the sql to make root can access mysql from remote host
	echo "use mysql;"                                                        > /tmp/init.sql
	echo "delete from user where user='root' and host!='localhost';"         >> /tmp/init.sql
	echo "update user set host='%' where user='root';"                       >> /tmp/init.sql
	echo "update user set password=PASSWORD('123456') where user='root';"    >> /tmp/init.sql
	echo "flush privileges;"                                                 >> /tmp/init.sql
fi

# Start mysqld
/usr/sbin/mysqld --user=u01 --init-file=/tmp/init.sql
