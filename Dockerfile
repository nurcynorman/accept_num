# Use the official Ubuntu base image
FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y bash xxd

# Copy the entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entry point to start the custom script
ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
