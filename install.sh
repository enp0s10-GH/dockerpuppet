apt update -y && apt upgrade -y
apt install wget -y
wget https://apt.puppetlabs.com/puppet-release-focal.deb
dpkg -i puppet-release-focal.deb
apt install perl -y
apt install net-tools -y
apt-get update -y
apt-get install puppetserver -y
HOSTNAME=$(cat /etc/hostname)
echo "${HOSTNAME} puppet" > /etc/hostname
echo "127.0.0.1 localhost puppet" > /etc/hosts
echo "::1	localhost ip6-localhost ip6-loopback" >> /etc/hosts
echo "fe00::0	ip6-localnet" >> /etc/hosts
echo "ff00::0	ip6-mcastprefix" >> /etc/hosts
echo "ff02::1	ip6-allnodes" >> /etc/hosts
echo "ff02::2	ip6-allrouters" >> /etc/hosts
echo "172.17.0.2	${HOSTNAME}" >> /etc/hosts
cat /etc/hosts
rm -rf /etc/puppetlabs/puppetserver/ca/*
rm -rf /etc/puppetlabs/puppet/ssl
/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver ca setup
/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver foreground
