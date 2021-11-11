#!/bin/bash
#
# This Script creates an docker container, and installs an puppetserver the container.

##############################
# Adding hostname puppet
##############################
ipcfg=$(ifconfig | awk '/inet/{print $2}');
IFS=" ";
read -ra ADDR <<< $ipcfg;
for ip in ${ADDR[0]}; do
HOSTNAME=$(cat /etc/hostname)
echo "${HOSTNAME} puppet" > /etc/hostname
echo "127.0.0.1   localhost puppet" > /etc/hosts
echo "$ip    ${HOSTNAME}" >> /etc/hosts
done;

##############################
# Installing & configuring puppetserver
##############################
$server=$SERVERCERT
echo "________"
echo $server;
echo "________"
apt-get install puppetserver -y
echo "export PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/server/apps/puppetserver/bin" >> ~/.bashrc
source ~/.bashrc
apt-get update -y && apt-get upgrade -y
rm -rf /etc/puppetlabs/puppetserver/ca
rm -rf /etc/puppetlabs/puppet/ssl
										 # ENTER YOUR PUPPETSERVER NAME
/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver ca setup --subject-alt-names ${SERVERCERT},puppet
/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver foreground


