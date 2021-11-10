#!/bin/bash
#
# This Script creates an docker container, and installs an puppetserver the container.

# Puppet command: /opt/puppetlabs/bin/puppet 
# Puppetserver command: /opt/puppetlabs/server/apps/puppetserver/bin/puppetserver

apt update -y && apt upgrade -y
##############################
# installing some dependencies
##############################
apt install wget -y
wget https://apt.puppetlabs.com/puppet-release-focal.deb
dpkg -i puppet-release-focal.deb
apt install perl -y
apt install net-tools -y
apt-get update -y
##############################
# Adding hostname puppet
##############################
HOSTNAME=$(cat /etc/hostname)
echo "${HOSTNAME} puppet" > /etc/hostname
echo "127.0.0.1   localhost puppet" > /etc/hosts
echo "::1   localhost ip6-localhost ip6-loopback" >> /etc/hosts
echo "fe00::0   ip6-localnet" >> /etc/hosts
echo "ff00::0   ip6-mcastprefix" >> /etc/hosts
echo "ff02::1   ip6-allnodes" >> /etc/hosts
echo "ff02::2   ip6-allrouters" >> /etc/hosts
echo "172.17.0.2     ${HOSTNAME}" >> /etc/hosts
##############################
# Installing & configuring puppet
##############################
apt purge puppet -y
apt autoremove -y
apt install puppet -y 
##############################
# Installing & configuring puppetserver
##############################
apt-get install puppetserver -y
apt-get update -y && apt-get upgrade -y
rm -rf /etc/puppetlabs/puppetserver/ca
rm -rf /etc/puppetlabs/puppet/ssl
/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver ca setup --subject-alt-names puppetserver.hetzner.company,puppet
/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver foreground


