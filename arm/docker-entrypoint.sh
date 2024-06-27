#!/bin/bash

## setup the local config file
#if [[ ! -f "/home/user/app/quartz/conf/config.local.ini" ]]; then
#  echo "******"
#  echo "For development on quartz, you need to create an account and put your credentials into config.local.ini"
#  echo "Until then, quartz will just complain about bad credentials."
#  echo "******"
#  install -m 0644 -o 1000 -g 1000 "/home/user/app/quartz/conf/config.ini" "/home/user/app/quartz/conf/config.local.ini"
#fi



echo "/home/user/app/quartz/usr/sbin/bluematador-agent" | tee /home/user/bluematador/exe-location

exec "$@"