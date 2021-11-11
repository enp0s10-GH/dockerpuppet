# Using Image Ubuntu:20.04
FROM ubuntu:20.04

# Copying the local install.sh into the container
COPY install.sh .
 
# Updating OS and installing dependencies
RUN apt update -y && apt upgrade -y; \
    apt install wget -y; \
    wget https://apt.puppetlabs.com/puppet-release-focal.deb; \
    dpkg -i puppet-release-focal.deb; \
    apt install perl -y; \
    apt install net-tools -y; \
    apt-get update -y; \
    apt -y -o DPkg::Options::=--force-confold install puppet-agent;

# Exposing Port 8140
EXPOSE 8140

# Execute install.sh at start of the container
ENTRYPOINT ["bash","install.sh"]

