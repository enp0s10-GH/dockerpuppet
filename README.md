
# dockerpuppet
Dockerpuppet is an open source project that helps you to create a puppet server,
that manage configurations in a Docker container 📁

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

Edit the install.sh file\
`
nano install.sh
`\
*You need to read all comments, to understand how it works*

Create the Image and start the Docker Container\
`
sudo docker-compose up -d
`

Switch in to the Terminal of the Container\
`
sudo docker exec -it dockerpuppet:latest /bin/bash
`

    
## Requirements

**REALLY IMPORTANT**

- Knowledge at Docker
- Knowledge at Puppet
- Knowledge in Bash.
- `Docker` https://docs.docker.com/engine/install
- That it works properly you need at least 2 servers, once the puppet server,which is set up by this project, and a puppet agent, which uses this server. More Informations at
  https://puppet.com/docs/puppet/5.5/man/agent.html \
  https://puppet.com/docs/
