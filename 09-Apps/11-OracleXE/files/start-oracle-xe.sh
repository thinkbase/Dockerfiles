#!/bin/bash

echo "$(date): Begin to start oracle XE service ..."

source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
unset http_proxy
unset https_proxy
env


/createListener.sh > $ORACLE_HOME/network/admin/listener.ora
/createTnsnames.sh > $ORACLE_HOME/network/admin/tnsnames.ora

# If volumn /u01/oradata exists, move database files to this volumn
/etc/init.d/oracle-xe stop
if [ -d "/u01/oradata/XE" ]
then
    echo "Database files are in /u01/oradata/XE, remove original files ..."
    rm -rfv /u01/app/oracle/oradata/XE
    ln -sv /u01/oradata/XE /u01/app/oracle/oradata/XE
    echo "Online log files are in /u01/oradata/fast_recovery_area/XE, remove original files ..."
    rm -rfv /u01/app/oracle/fast_recovery_area/XE
    ln -sv /u01/oradata/fast_recovery_area/XE /u01/app/oracle/fast_recovery_area/XE
elif [ -d "/u01/oradata" ]
then
    echo "Move original database files to /u01/oradata/XE before starting ..."
    chown -v oracle:dba /u01/oradata
    mv -v /u01/app/oracle/oradata/XE /u01/oradata/XE
    ln -sv /u01/oradata/XE /u01/app/oracle/oradata/XE
    # Move onlinelog from /u01/app/oracle/fast_recovery_area/XE to /u01/oradata/fast_recovery_area/XE
    mkdir -p /u01/oradata/fast_recovery_area
    mv -v /u01/app/oracle/fast_recovery_area/XE /u01/oradata/fast_recovery_area/XE
    ln -sv /u01/oradata/fast_recovery_area/XE /u01/app/oracle/fast_recovery_area/XE
fi 

/etc/init.d/oracle-xe start

echo "$(date): oracle XE service started."

