
# dockerpuppet
Dockerpuppet is a OpenSource Project, that creates an Docker Container and installs an puppetserver into this container. 
It's all automatic, so you only need to install docker and an Puppetagent, how to install an Puppet Agent?.
**READ THIS** 

` DONT EXECUTE THE install.sh locally! It may destroy your Operating Systems Network configuration `
## Installation

Here you see, how to install dockerpuppet on your server\
**ATTENTION:** please look at our Requirements, else it wont work correctly!

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

Finished! If you configured the puppetagent correctly and startet the Container, it should work.

It doesnt work? Re-check your configuration or ask me!

    
## Requirements

**REALLY IMPORTANT**

- Knowledge at Docker
- Knowledge at Puppet
- Knowledge in Bash.
- `Docker` https://docs.docker.com/engine/install
- That it works properly you need at least 2 servers, once the puppet server,which is set up by this project, and a puppet agent, which uses this server. More Informations at
  https://puppet.com/docs/puppet/5.5/man/agent.html \
  https://puppet.com/docs/
