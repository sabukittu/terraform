#!/bin/bash

yum install -y java \
	vim \
	git \
	awscli \
	wget 

dd if=/dev/zero of=/swapfile bs=2048 count=1048576
chmod 600 /swapfile
mkswap /swapfile
echo "/swapfile swap swap defaults 0 0" >>/etc/fstab
swapon /swapfile

groupadd -g 1050 docker  
usermod -aG docker centos 
curl -fsSL https://get.docker.com | bash 
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/sbin/docker-compose 
chmod +x /usr/local/sbin/docker-compose
systemctl start docker