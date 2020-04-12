#!/bin/bash
set -x

SLAVE_CFG='/var/jenkins_home/nodes/Slave01/config.xml'
OLD_IP=`cat $SLAVE_CFG | grep 172.31 | cut -c 11- | rev | cut -c 8- | rev`
NEW_IP=`terraform output -no-color | awk '{print $3}'`
sed -i "s/$OLD_IP/$NEW_IP/g" $SLAVE_CFG
