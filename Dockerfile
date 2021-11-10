# Using the Ubuntu Image
FROM ubuntu:20.04

# Copy the local install.sh into the container
COPY install.sh . 

# Set the entry point
ENTRYPOINT ["bash","/install.sh"]

# Expose the port 8140
EXPOSE 8140
