#!/bin/bash
set -e
set -x

# deploy supervisor
cp /tmp/files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# finally
rm -rfv /tmp/files