# Use the latest Ubuntu LTS as the base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update apt repository and install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    expect \
 && rm -rf /var/lib/apt/lists/* # Clean up to reduce image size

# Download the evtd binary and set permissions
RUN wget https://github.com/EverestSmartChain/EverestSmartChain/releases/download/0.1/evtd -O /usr/local/bin/evtd \
 && chmod +x /usr/local/bin/evtd

# Copy the entrypoint script into the image and set permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose necessary ports
EXPOSE 26656 26657 1317 9090 8545 8546 6065

# Use the entrypoint script to initialize and start the evtd node
ENTRYPOINT ["/entrypoint.sh"]
