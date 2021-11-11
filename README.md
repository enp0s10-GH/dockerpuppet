![Logo](https://i.imgur.com/hj6ygfZ.png)
# dockerpuppet
Dockerpuppet is a OpenSource Project, that creates an Docker Container and installs an puppetserver into this container. 
It's all automatic, so you only need to install docker and an Puppetagent, how to install an Puppet Agent?.
**READ THIS** 

` DONT EXECUTE THE install.sh locally! It may destroy your Operating Systems Network configuration `
## Installation

Here you see, how to install dockerpuppet on your server\
**ATTENTION:** please look at our Requirements, else it wont work correctly!

### Puppetserver

Clone the Repository to your Server\
`
git clone https://github.com/enforcer-GH/dockerpuppet.git
`

Switch to the directory\
`
cd dockerpuppet
`

Edit the `docker-compose.yml` and change `CERTNAME` to your servers certificate name given on your *puppetagent*.

Create the Image, Build and start the Docker Container\
`
sudo docker-compose up 
`
### Puppetagent

```
wget https://apt.puppetlabs.com/puppet-release-focal.deb
sudo dpkg -i puppet-release-focal.deb
sudo apt-get update 
sudo apt-get install puppet-agent 

sudo vim /etc/puppetlabs/puppet/puppet.conf

[main]
certname = puppetagent.example.com
server = puppetmaster.example.com
runinterval = 30m

sudo systemctl start puppet
sudo systemctl enable puppet

sudo systemctl status puppet -> Check if Puppetagent is started
```

Finished! If you configured the puppetagent correctly and startet the Container, it should work.

It doesnt work? Re-check your configuration or ask me!

    
## Requirements

**REALLY IMPORTANT**

- Knowledge at Docker
- Knowledge at Puppet
- `Docker` https://docs.docker.com/engine/install

**Nice to have**
- Knowledge in Bash.

That it works properly you need at least 2 servers, once the puppet server,which is set up by this project, and a puppet agent, which uses this server. More Informations at
  https://puppet.com/docs/puppet/5.5/man/agent.html \
  https://puppet.com/docs/

## Authors

- [@enforcer-GH](https://www.github.com/enforcer-GH)
