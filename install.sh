#!/bin/bash
#
# This Script creates an docker container, and installs an puppetserver the container.

#######################################
# function to install packages
# Arguments:
#   $1: package name
# Returns:
#   apt install $1
#######################################
function install() {
  local package="${1}"
  apt install "${package}" -y
}

#######################################
# Adding hostname puppet
# Output:
#   Overwrites the /etc/hosts   
#######################################
function handle_host() {
  local ipcfg="$(ifconfig | awk '/inet/{print $2}')"
  IFS=" "
  read -ra addr <<< "${ipcfg}"
  for ip_address in "${addr[0]}"; do
    local hostname="$(cat /etc/hostname)"
    echo "${hostname} puppet" > /etc/hostname
    echo '127.0.0.1   localhost puppet' > /etc/hosts
    echo "${ip_address}    ${hostname}" >> /etc/hosts
  done
  echo "1";
}

#######################################
# Installing, Configuring and starting of the puppetserver.
# Globals:
#   PATH
#   SERVERCERT 
# Output:
#   Writes 2 paths to .bashrc
#######################################
function setup() {
  local cert="${SERVERCERT}"
  install puppetserver
  echo "export PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/server/apps/puppetserver/bin" >> ~/.bashrc
  source /root/.bashrc
  apt-get update -y && apt-get upgrade -y
  rm -rf /etc/puppetlabs/puppetserver/ca
  rm -rf /etc/puppetlabs/puppet/ssl
  /opt/puppetlabs/server/apps/puppetserver/bin/puppetserver ca setup --subject-alt-names "${cert}",puppet
  /opt/puppetlabs/server/apps/puppetserver/bin/puppetserver foreground
}

if [[ "$(handle_host)" -eq "1" ]]; then
  setup
else 
  echo "Something went wrong.";
fi

