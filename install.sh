#!/bin/bash
#
# This Script creates an docker container, and installs an puppetserver the container.
# 
confdir="/etc/puppetlabs/puppet/"
agent_certs=("puppetagent1.hetzner.company")

#######################################
# function to install packages
# Arguments:
#   $1: package name
# Returns:
#   apt install $1
#######################################
function install() {
  package="${1}"
  apt install "${package}" -y
}

#######################################
# Adding hostname puppet
# Output:
#   Overwrites the /etc/hosts   
#######################################
function handle_host() {
  ipcfg="$(ifconfig | awk '/inet/{print $2}')"
  IFS=" "
  read -ra addr <<< "${ipcfg}"
  for ip_address in ${addr[0]}; do
    hostname="$(cat /etc/hostname)"
    echo "${hostname} puppet" > /etc/hostname
    echo '127.0.0.1   localhost puppet' > /etc/hosts
    echo "${ip_address}    ${hostname}" >> /etc/hosts
  done
  echo "1"
}

#######################################
# Autosignes all given puppetagents if AUTOSIGN true 
# Globals:
#   AUTOSIGN 
# Output:
#  true:
#   Writes autosign = true to confdir/puppet.conf
#   Adds the agent certs to confdir/autosign.conf
#  false:
#   Writes autosign = false to confdir/puppet.conf
#######################################
function handle_autosign() {
  autosigning="${AUTOSIGN}"
  case "${autosigning}" in
    true) 
      touch "${confdir}"/autosign.conf
      for certificate in "${agent_certs[@]}"; do
        echo "${certificate}" >> "${confdir}"/autosign.conf
      done
      echo "autosign = true" >> "${confdir}/puppet.conf"
      echo "AUTOSIGN ACTIVE!";;
    false) 
      echo "autosign = false" >> "${confdir}/puppet.conf"
      echo "AUTOSIGN INACTIVE!";;
  esac
     
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
  cert="${SERVERCERT}"
  install puppetserver
  echo "export PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/server/apps/puppetserver/bin" >> ~/.bashrc
  source /root/.bashrc
  handle_autosign
  apt-get update -y && apt-get upgrade -y
  rm -rf /etc/puppetlabs/puppetserver/ca
  rm -rf /etc/puppetlabs/puppet/ssl
  /opt/puppetlabs/server/apps/puppetserver/bin/puppetserver ca setup --subject-alt-names "${cert}",puppet
  /opt/puppetlabs/server/apps/puppetserver/bin/puppetserver foreground
}

if [[ "$(handle_host)" -eq "1" ]]; then
  setup
else 
  echo "Something went wrong."
fi

