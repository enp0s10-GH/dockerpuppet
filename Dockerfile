FROM ubuntu:20.04
COPY install.sh . 
#ENTRYPOINT ["/bin/sh", "-c" , "echo 172.17.0.2   dockerpuppet puppet >> /etc/hosts && echo dockerpuppet puppet > /etc/hostname" ]
ENTRYPOINT ["bash","/install.sh"]
EXPOSE 8140
