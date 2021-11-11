#!/bin/bash
#
# This Script creates an docker container, and installs an puppetserver the container.

##############################
# Adding hostname puppet
##############################
function handle_host() {
  ipcfg=$(ifconfig | awk '/inet/{print $2}');
  IFS=" ";
  read -ra addr <<< "${ipcfg}";
  for ip_address in ${addr[0]}; do
    hostname=$(cat /etc/hostname)
    echo "${hostname} puppet" > /etc/hostname
    echo "127.0.0.1   localhost puppet" > /etc/hosts
    echo "$ip_address    ${hostname}" >> /etc/hosts
  done;
}
handle_host;

##############################
# Installing & configuring puppetserver
##############################
apt-get install puppetserver -y
echo "export PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/server/apps/puppetserver/bin" >> ~/.bashrc
source /root/.bashrc
apt-get update -y && apt-get upgrade -y
rm -rf /etc/puppetlabs/puppetserver/ca
rm -rf /etc/puppetlabs/puppet/ssl
/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver ca setup --subject-alt-names "${SERVERCERT}",puppet
/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver foreground


